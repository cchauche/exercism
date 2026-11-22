use time::PlainDateTime as DateTime;
use time::Duration;
use std::ops::Add;

// Returns a DateTime one billion seconds after start.
pub fn after(start: DateTime) -> DateTime {
    let giga_seconds = Duration::new(1_000_000_000, 0);
    start.add(giga_seconds)
}
