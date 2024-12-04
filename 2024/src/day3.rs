use regex::Regex;
use std::fs::File;
use std::io;
use std::io::prelude::*;

pub fn call() -> io::Result<()> {
  let mut file = File::open("inputs/day3.txt")?;
  let mut contents = String::new();
  file.read_to_string(&mut contents)?;

  dbg!(calc_sum(&contents));

  let donot_re = Regex::new(r"don't\(\)(?s:.)+?(do\(\)|$)").unwrap();
  let contents_wo_donot = donot_re.replace_all(&contents, "").to_string();

  dbg!(calc_sum(&contents_wo_donot));
  
  Ok(())
}

fn calc_sum(str: &String) -> i32 {
  let mul_re = Regex::new(r"mul\((\d+),(\d+)\)").unwrap();

  mul_re
    .captures_iter(&str)
    .map(|m| m[1].parse::<i32>().unwrap() * m[2].parse::<i32>().unwrap())
    .sum()
}