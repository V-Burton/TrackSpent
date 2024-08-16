use std::collections::{HashMap, VecDeque};
use chrono::NaiveDate;
use serde::{Deserialize, Serialize};
use lazy_static::lazy_static;

#[derive(Serialize, Deserialize, Debug)]
pub struct Transaction {
    id: String,
    #[serde(rename = "accountId")]
    account_id: String,
    amount: Amount,
    descriptions: Descriptions,
    dates: Dates,
    types: Types,
    status: String,
    reference: String,
    #[serde(rename = "providerMutability")]
    provider_mutability: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Amount {
    value: ValueDetail,
    #[serde(rename = "currencyCode")]
    currency_code: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ValueDetail {
    #[serde(rename = "unscaledValue")]
    unscaled_value: String,
    scale: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Descriptions {
    original: String,
    display: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Dates {
    booked: String,
    value: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Types {
    #[serde(rename = "type")]
    kind: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct TransactionsData {
    transactions: Vec<Transaction>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Spent {
    pub reason: String,
    #[serde(with = "chrono::NaiveDate")]
    pub date: NaiveDate,
    pub amount: f64,
}

lazy_static! {
    static ref OUTCOME: std::sync::Mutex<HashMap<String, Vec<Spent>>> = std::sync::Mutex::new(HashMap::new());
    static ref INCOME: std::sync::Mutex<HashMap<String, Vec<Spent>>> = std::sync::Mutex::new(HashMap::new());
    static ref RESULT: std::sync::Mutex<VecDeque<Spent>> = std::sync::Mutex::new(VecDeque::new());
}

pub fn get_formatted_date(date: NaiveDate) -> String {
    date.format("%Y-%m-%d").to_string()
}

pub fn parse_and_use_date(date_str: String) -> Result<(), String> {
    let parsed_date = NaiveDate::parse_from_str(&date_str, "%Y-%m-%d")
        .map_err(|e| e.to_string())?;
    
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_key_outcome() -> Vec<String> {
    let outcome = OUTCOME.lock().unwrap();
    outcome.keys().cloned().collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_key_income() -> Vec<String> {
    let income = INCOME.lock().unwrap();
    income.keys().cloned().collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn init_app() {
    intialize();
    initialize_result_with_dummy_data();
}

pub fn intialize() {
    let mut outcome = OUTCOME.lock().unwrap();
    let mut income = INCOME.lock().unwrap();

    outcome.insert("Charges".to_string(), Vec::new());
    outcome.insert("Food".to_string(), Vec::new());
    outcome.insert("Save".to_string(), Vec::new());
    outcome.insert("Other".to_string(), Vec::new());

    income.insert("Revenu".to_string(), Vec::new());
    income.insert("Refund".to_string(), Vec::new());
    income.insert("Gift".to_string(), Vec::new());
    income.insert("Other".to_string(), Vec::new());
}

pub fn initialize_result_with_dummy_data() {
    let mut result = RESULT.lock().unwrap();

    result.push_back(Spent {
        reason: "Groceries".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 1).expect("REASON"),
        amount: -50.25,
    });

    result.push_back(Spent {
        reason: "Revenue".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 12).expect("REASON"),
        amount: 3400.00,
    });

    result.push_back(Spent {
        reason: "Rent".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 5).expect("REASON"),
        amount: -1200.00,
    });

    result.push_back(Spent {
        reason: "Utilities".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 7).expect("REASON"),
        amount: -75.40,
    });

    result.push_back(Spent {
        reason: "Dining Out".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 10).expect("REASON"),
        amount: -35.70,
    });

    result.push_back(Spent {
        reason: "Internet".to_string(),
        date: NaiveDate::from_ymd_opt(2024, 8, 12).expect("REASON"),
        amount: -60.00,
    });
}

#[flutter_rust_bridge::frb(sync)]
pub fn load_transactions_from_file() -> Result<(), String> {
    let file_content = std::fs::read_to_string("/Users/victor/Documents/Code/TrackSpent/front/rust/src/checkData.json").expect("Unable to read file");
    let mut data: TransactionsData = serde_json::from_str(&file_content).expect("Unable to parse JSON");
    
    push_transaction_to_result(&mut data);
    
    Ok(())
}

pub fn push_transaction_to_result(data: &mut TransactionsData) {
    data.transactions.reverse();
    let mut result = RESULT.lock().unwrap();
    for transaction in &data.transactions {
        let display = &transaction.descriptions.display;
        let date = &transaction.dates.value;
        let value = &transaction.amount.value.unscaled_value;
        let scale = transaction.amount.value.scale.parse::<i32>().expect("Unable to parse scale");
        let unscaled_value = value.parse::<f64>().expect("Unable to parse unscaled value");
        let scaled_value = unscaled_value / 10f64.powi(scale);
        
        let check = Spent {
            reason: display.clone(),
            date: NaiveDate::parse_from_str(date, "%Y-%m-%d").expect("Unable to parse date"),
            amount: scaled_value,
        };

        println!("Adding transaction: {:?}", check);
        result.push_front(check);
    }
    println!("Total transactions in RESULT: {}", result.len());

}

pub fn get_spent() -> Result<Option<Spent>, String> {
    let mut result = RESULT.lock().unwrap();
    if result.is_empty() {
        return Ok(None);
    }
    Ok(Some(result.pop_front().unwrap()))
}


#[flutter_rust_bridge::frb(sync)]
pub fn get_value(indice: usize) -> String {
    let result = RESULT.lock().unwrap();
    let value = result[indice].amount.clone();
    format!("{}", value)
}

#[flutter_rust_bridge::frb(sync)]
pub fn debug_result_length() -> usize {
    let result = RESULT.lock().unwrap();
    result.len()
}

#[flutter_rust_bridge::frb(sync)]
pub fn add_to_income(category: &str, spent: Spent) {
    let mut income = INCOME.lock().unwrap();
    let mut category_spent = income.get_mut(category).unwrap();
    category_spent.push(spent);
}

#[flutter_rust_bridge::frb(sync)]
pub fn add_to_outcome(category: &str, spent: Spent) {
    let mut outcome = OUTCOME.lock().unwrap();
    let mut category_spent = outcome.get_mut(category).unwrap();
    category_spent.push(spent);
}

#[flutter_rust_bridge::frb(sync)]
pub fn add_new_category(category: &str, income: bool) {
    if income {
        let mut income = INCOME.lock().unwrap();
        income.insert(category.to_string(), Vec::new());
    } else {
        let mut outcome = OUTCOME.lock().unwrap();
        outcome.insert(category.to_string(), Vec::new());
    }
}

#[flutter_rust_bridge::frb(sync)]
pub fn test() -> String {
    println!("Test function called");
    let res;
    {
        let result = RESULT.lock().unwrap();
        if result.len() < 2 {
            return format!("Not enough dataaaa");
        }    
        let a = result[0].amount;
        let b = result[1].amount;
        
        res = a + b;
    }

    return format!("{}", res);
}
