Week 3 Single Line Functions

Concepts
- the built-in "dual" table

Single Line Functions
NOTE: value often means field name
STRING FUNCTIONS
- to_char(value, format)
- upper, lower, initcap, 
- concat, substr, length, instr, 
- lpad, rpad, trim
- to_date(date string, format string)
- replace(value, string to replace, replacement string)

MATH FUNCTIONS
- round(value, # decimals), trunc(value, #decimals), mod(value)
- Ceil, Floor

DATE FUNCTIONS
- next_day(value, day name string), last_day, add_months, months_between, 
- round, trunc, sysdate

MISC FUNCTIONS
- case() - used in case selects
- NVL(value, replacement string)

CALCULATED FIELDS
- using either single line functions, or mathematics to alter the field values
- usually require an alias to be assigned