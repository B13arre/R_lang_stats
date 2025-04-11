library(binom)
binom.confint(x = 531, n = 648, method = "all")


dbinom(x=3,  size=5, prob=(1/6))

binom.test(3, 10, p = 0.8194)

binom.test(3, 10, p = 0.8194)

# Perform the exact binomial test
result <- binom.test(3, 10, p = 0.8194)

# View the result
print(result)

# Multiply the p-value by 2 (although binom.test gives two-tailed by default)
adjusted_p_value <- result$p.value * 2
cat("Doubled p-value:", adjusted_p_value, "\n")

result <- binom.test(531, 648, p = 0.5)
# View the result
print(result)

# Multiply the p-value by 2 (although binom.test gives two-tailed by default)
adjusted_p_value <- result$p.value * 2
cat("Doubled p-value:", adjusted_p_value, "\n")

2*pnorm(q=16.2242,lower.tail=FALSE)


# Given values
x <- 19613      # observed number of males
n <- 25675      # total number of admissions
p <- 0.5        # assumed probability under H0

# Mean and standard deviation
mu <- n * p
sigma <- sqrt(n * p * (1 - p))

# Apply continuity correction and calculate z-score
z <- (x - 0.5 - mu) / sigma

# Calculate upper tail probability (P(X ≥ 19613))
p_value <- pnorm(z, lower.tail = FALSE)

# Output
cat("Z-score:", z, "\n")
cat("Approximate p-value (normal approx with continuity correction):", p_value, "\n")
