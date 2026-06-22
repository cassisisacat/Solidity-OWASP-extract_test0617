// integer-mate/sui/sources/math_u256.move
// VULNERABLE: incorrect overflow threshold
public fun checked_shlw(n: u256): (u256, bool) {
    let mask = 0xFFFFFFFFFFFFFFFF << 192;  // WRONG! Produces wrong threshold
    if (n > mask) {
        (0, true)   // Should signal overflow
    } else {
        ((n << 64), false)  // Overflow occurs here for n >= 2^192—Move truncates silently
    }
}
