use std::io;
use std::env;

mod day1;

fn main() -> io::Result<()> {
  let args: Vec<String> = env::args().collect();

  let _ = match args[1].as_str() {
    "1" => day1::call(),
    _ => panic!(""),
  };

  Ok(())
}