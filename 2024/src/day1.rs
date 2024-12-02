use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::collections::HashMap;

pub fn call() -> io::Result<()> {
  let mut file = File::open("day1.txt")?;
  let mut contents = String::new();
  file.read_to_string(&mut contents)?;

  let (mut left_list, mut right_list) = contents
    .split_whitespace()
    .map(|num| num.parse::<i32>().unwrap())
    .into_iter()
    .enumerate()
    .fold((vec![], vec![]), |(mut evens, mut odds), (idx, num)| {
      if idx % 2 == 0 {
        evens.push(num);
      } else {
        odds.push(num);
      }
      (evens, odds)
    });
    
  left_list.sort();
  right_list.sort();

  let distance: i32 = left_list.iter()
    .zip(right_list.iter())
    .fold(0, |acc, (&x, &y)| acc + (x - y).abs());

  dbg!(distance);

  let right_counts = right_list.into_iter().fold(HashMap::new(), |mut acc, num| {
    *acc.entry(num).or_insert(0) += 1;
    acc
  });

  let simularity_score = left_list
    .into_iter()
    .fold(0, |acc, num| acc + num * *right_counts.get(&num).unwrap_or(&0));

  dbg!(simularity_score);

  Ok(())
}