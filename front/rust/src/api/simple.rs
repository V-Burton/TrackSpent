use std::collections::{HashMap, VecDeque};
use chrono::NaiveDate;
use serde::{Deserialize, Serialize};
use lazy_static::lazy_static;
use std::fs;
use std::io;

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

#[flutter_rust_bridge::frb(sync)]
pub fn init_app() {
    intialize();
    let file_content = fs::read_to_string("checkData.json").expect("Unable to read file");
    let mut data: TransactionsData = serde_json::from_str(&file_content).expect("Unable to parse JSON");

    
    push_transaction_to_result(&mut data);
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
pub fn load_transactions_from_file(file_path: String) -> Result<(), String> {
    let file_content = std::fs::read_to_string(file_path).expect("Unable to read file");
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

        result.push_front(check);
    }
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_spent_list() -> Vec<Spent> {
    let result = RESULT.lock().unwrap();
    result.clone().into()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_value(indice: usize) -> String {
    let result = RESULT.lock().unwrap();
    let value = result[indice].amount;
    format!("{}", value)
}
