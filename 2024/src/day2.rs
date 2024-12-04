use std::fs::File;
use std::io;
use std::io::prelude::*;

pub fn call() -> io::Result<()> {
  let mut file = File::open("inputs/day2.txt")?;
  let mut contents = String::new();
  file.read_to_string(&mut contents)?;

  let reports: Vec<Vec<i32>> = contents
    .lines()
    .map(|line| {
      line
        .split_whitespace()
        .map(|num| num.parse::<i32>().unwrap())
        .collect()
    })
    .collect();

  let safe_count = reports
    .iter()
    .filter(|report| check_safe(report))
    .count();

  dbg!(safe_count);

  let tolerant_safe_count = reports
    .iter()
    .filter(|report| check_tolerant_safe(report))
    .count();

  dbg!(tolerant_safe_count);
  
  Ok(())
}

fn check_safe(report: &Vec<i32>) -> bool {
  let mut iter = report.iter();
  let mut prev: i32 = *iter.next().unwrap();
  let mut is_asc: Option<bool> = None;

  for &curr in iter {
    if is_asc.is_none() {
      is_asc = Some(prev < curr);
    }
    
    if !check_typle(prev, curr, is_asc) {
      return false
    }
    prev = curr;
  }
  true
}

fn check_typle(left: i32, right: i32, is_asc: Option<bool>) -> bool {
  let diff = (left - right).abs();
  diff > 0 && diff < 4 && is_asc.is_none_or(|is_asc| is_asc == (left < right))
}

fn check_tolerant_safe(report: &Vec<i32>) -> bool {
  let mut iter = report.iter();
  let mut prev: i32 = *iter.next().unwrap();
  let mut is_asc: Option<bool> = None;

  for (idx, &curr) in iter.enumerate() {
    if is_asc.is_none() {
      is_asc = Some(prev < curr);
    }
    
    if !check_typle(prev, curr, is_asc) {
      return check_safe_without_one(report, idx) || 
        check_safe_without_one(report, idx + 1) ||
        idx == 1 && check_safe_without_one(report, 0)
    }
    prev = curr;
  }
  true
}

fn check_safe_without_one(report: &Vec<i32>, idx: usize) -> bool {
  let mut report_without_one = report.clone();
  report_without_one.remove(idx);

  check_safe(&report_without_one)
}