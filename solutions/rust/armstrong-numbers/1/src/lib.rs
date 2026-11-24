pub fn is_armstrong_number(num: u32) -> bool {
    let num_as_string = format!("{num}");
    let digits = num_as_string.len() as u32;
    let mut sum: u32 = 0;
    
    for c in num_as_string.chars() {
        let i = c.to_digit(10).unwrap();
        sum += i.pow(digits);
    }
    
    num == sum
}
