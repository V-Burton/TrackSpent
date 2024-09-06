use std::collections::{HashMap, VecDeque};
use chrono::{NaiveDate, Datelike};
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
    //To Do had list for Outcome and Income so the buttons always diosplay in the same order
}

pub fn get_formatted_date(date: NaiveDate) -> String {
    date.format("%Y-%m-%d").to_string()
}

pub fn parse_and_use_date(date_str: String) -> Result<(), String> {
    let _parsed_date = NaiveDate::parse_from_str(&date_str, "%Y-%m-%d")
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
    let result = RESULT.lock().unwrap();
    if result.is_empty() {
        return Ok(None);
    }
    Ok(Some(result.front().unwrap().clone()))
}

fn remove_spent() {
    let mut result = RESULT.lock().unwrap();
    result.pop_front();
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
    let category_spent = income.get_mut(category).unwrap();
    category_spent.push(spent);
    remove_spent();
}

#[flutter_rust_bridge::frb(sync)]
pub fn add_to_outcome(category: &str, spent: Spent) {
    let mut outcome = OUTCOME.lock().unwrap();
    let  category_spent = outcome.get_mut(category).unwrap();
    category_spent.push(spent);
    remove_spent();
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

#[flutter_rust_bridge::frb(sync)]
pub fn get_outcome_data() -> HashMap<String, f64> {
    let outcome = OUTCOME.lock().unwrap();
    outcome.iter().map(|(k, v)| (k.clone(), v.iter().map(|spent| spent.amount).sum())).collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_income_data() -> HashMap<String, f64> {
    let income = INCOME.lock().unwrap();
    income.iter().map(|(k, v)| (k.clone(), v.iter().map(|spent| spent.amount).sum())).collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_outcome_data_by_date(month: u32, year: i32) -> HashMap<String, f64> {
    let outcome = OUTCOME.lock().unwrap();
    outcome.iter().map(|(k, v)| (k.clone(), v.iter().filter(|spent| spent.date.month() == month && spent.date.year() == year).map(|spent| spent.amount).sum())).collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_income_data_by_date(month: u32, year: i32) -> HashMap<String, f64> {
    let income = INCOME.lock().unwrap();
    income.iter().map(|(k, v)| (k.clone(), v.iter().filter(|spent| spent.date.month() == month && spent.date.year() == year).map(|spent| spent.amount).sum())).collect()
}



//////////////////////////////////
/// 
/// 
/// ///
pub fn initialize_result_with_dummy_data() {
    let mut result = RESULT.lock().unwrap();

    let data = vec![
        ("Test", NaiveDate::from_ymd_opt(2023, 1, 1), -50.25),
        ("Groceries", NaiveDate::from_ymd_opt(2024, 8, 1), -50.25),
        ("Revenue", NaiveDate::from_ymd_opt(2024, 8, 12), 3400.00),
        ("Rent", NaiveDate::from_ymd_opt(2024, 8, 5), -1200.00),
        ("Utilities", NaiveDate::from_ymd_opt(2024, 8, 7), -75.40),
        ("Dining Out", NaiveDate::from_ymd_opt(2024, 8, 10), -35.70),
        ("Internet", NaiveDate::from_ymd_opt(2024, 8, 12), -60.00),
        ("Transportation", NaiveDate::from_ymd_opt(2024, 8, 13), -45.00),
        ("Books", NaiveDate::from_ymd_opt(2024, 8, 14), -30.00),
        ("Gym Membership", NaiveDate::from_ymd_opt(2024, 8, 15), -55.00),
        ("Movie Tickets", NaiveDate::from_ymd_opt(2024, 8, 16), -25.00),
        ("Subscriptions", NaiveDate::from_ymd_opt(2024, 8, 17), -40.00),
        ("Phone Bill", NaiveDate::from_ymd_opt(2024, 8, 18), -70.00),
        ("Medical", NaiveDate::from_ymd_opt(2024, 8, 19), -90.00),
        ("Clothing", NaiveDate::from_ymd_opt(2024, 8, 20), -85.00),
        ("Coffee", NaiveDate::from_ymd_opt(2024, 8, 21), -15.00),
        ("Books", NaiveDate::from_ymd_opt(2024, 8, 22), -35.00),
        ("Supplies", NaiveDate::from_ymd_opt(2024, 8, 23), -22.50),
        ("Rent", NaiveDate::from_ymd_opt(2024, 8, 24), -1200.00),
        ("Groceries", NaiveDate::from_ymd_opt(2024, 8, 25), -52.75),
        ("Dining Out", NaiveDate::from_ymd_opt(2024, 8, 26), -40.00),
        ("Utilities", NaiveDate::from_ymd_opt(2024, 8, 27), -77.00),
        ("Internet", NaiveDate::from_ymd_opt(2024, 8, 28), -62.00),
        ("Transportation", NaiveDate::from_ymd_opt(2024, 8, 29), -47.50),
        ("Books", NaiveDate::from_ymd_opt(2024, 8, 30), -28.00),
        ("Medical", NaiveDate::from_ymd_opt(2024, 8, 31), -95.00),
        ("Coffee", NaiveDate::from_ymd_opt(2024, 8, 2), -18.00),
        ("Supplies", NaiveDate::from_ymd_opt(2024, 8, 3), -20.00),
        ("Phone Bill", NaiveDate::from_ymd_opt(2024, 8, 4), -75.00),
        ("Subscriptions", NaiveDate::from_ymd_opt(2024, 8, 6), -42.00),
        ("Transportation", NaiveDate::from_ymd_opt(2024, 8, 8), -50.00),
        ("Books", NaiveDate::from_ymd_opt(2024, 8, 9), -33.00),
        ("Medical", NaiveDate::from_ymd_opt(2024, 8, 11), -88.00),
        ("Clothing", NaiveDate::from_ymd_opt(2024, 8, 13), -60.00),
        ("Coffee", NaiveDate::from_ymd_opt(2024, 8, 14), -20.00),
        ("Dining Out", NaiveDate::from_ymd_opt(2024, 8, 15), -35.00),
        ("Groceries", NaiveDate::from_ymd_opt(2024, 8, 16), -55.00),
        ("Rent", NaiveDate::from_ymd_opt(2024, 8, 17), -1200.00),
        ("Utilities", NaiveDate::from_ymd_opt(2024, 8, 18), -80.00),
        ("Internet", NaiveDate::from_ymd_opt(2024, 8, 19), -65.00),
        ("Transportation", NaiveDate::from_ymd_opt(2024, 8, 20), -55.00),
        ("Books", NaiveDate::from_ymd_opt(2024, 8, 21), -30.00),
        ("Medical", NaiveDate::from_ymd_opt(2024, 8, 22), -90.00),
        ("Clothing", NaiveDate::from_ymd_opt(2024, 8, 23), -85.00),
        ("Supplies", NaiveDate::from_ymd_opt(2024, 8, 24), -25.00),
        ("Coffee", NaiveDate::from_ymd_opt(2024, 8, 25), -22.00),
        ("Phone Bill", NaiveDate::from_ymd_opt(2024, 8, 26), -70.00),
        ("Subscriptions", NaiveDate::from_ymd_opt(2024, 8, 27), -45.00),
        ("Dining Out", NaiveDate::from_ymd_opt(2024, 8, 28), -32.00),
        ("Groceries", NaiveDate::from_ymd_opt(2024, 8, 29), -55.00),
        ("Transportation", NaiveDate::from_ymd_opt(2024, 8, 30), -60.00),
        ("Medical", NaiveDate::from_ymd_opt(2024, 8, 31), -85.00),
    ];

    for (reason, date, amount) in data {
        result.push_back(Spent {
            reason: reason.to_string(),
            date: date.unwrap(),
            amount,
        });
    }
}