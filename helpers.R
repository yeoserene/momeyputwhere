dbs <- function(salary, cc, home_loan, insure, invest, savings){
  if (is.na(salary)){
    salary = 0
  }
  if (is.na(cc)){
    cc = 0
  }
  if (is.na(home_loan)){
    home_loan = 0
  }
  if (is.na(insure)){
    insure = 0
  }
  if (is.na(invest)){
    invest = 0
  }
  if (is.na(savings)){
    savings = 0
  }
  ir = 0.05
  all_sum = salary + cc + home_loan + insure + invest
  check_num = 0
  if (cc > 0){
    check_num = check_num + 1
  }
  if (home_loan >0){
    check_num = check_num + 1
  }
  if (insure > 0){
    check_num = check_num + 1
  }
  if (invest > 0){
    check_num = check_num + 1
  }
    
  if (check_num == 1){
    if (all_sum >= 2000 && all_sum < 2500){
      ir = 1.55
    }
    else if (all_sum >= 2500 && all_sum < 5000){
      ir = 1.85
    }
    else if (all_sum >= 5000 && all_sum < 15000){
      ir = 1.90
    }
    else if (all_sum >= 15000 && all_sum < 30000){
      ir = 2.00
    }
    else if (all_sum >= 30000){
      ir = 2.08
    }
  }
  else if (check_num > 1){
    if (all_sum >= 2000 && all_sum < 2500){
      ir = 1.80
    }
    else if (all_sum >= 2500 && all_sum < 5000){
      ir = 2.00
    }
    else if (all_sum >= 5000 && all_sum < 15000){
      ir = 2.20
    }
    else if (all_sum >= 15000 && all_sum < 30000){
      ir = 2.30
    }
    else if (all_sum >= 30000){
      ir = 3.50
    }
  }
  
  if (savings >= 50000){
    rem = 50000
    additional = savings-rem
  }  
  else{
    rem = savings
    additional = 0
  }
    
  total_amt = ir/100*rem + 0.05/100*additional
  
  return (total_amt)
}

uob <- function(salary, cc, giro, savings){
  if (is.na(salary)){
    salary = 0
  }
  if (is.na(cc)){
    cc = 0
  }
  if (is.na(giro)){
    giro = 0
  }
  if (is.na(savings)){
    savings=0
  }
  
  ir = 0.05
  int = 0
  check_num = 0
  if (salary > 0){
    check_num = check_num + 1
  }
  if (giro == "Yes"){
    check_num = check_num + 1
  }
  if (cc >= 500 && check_num == 0){
    int = 1.45/100*max(savings,75000)
  }
  else if (cc >= 500 && check_num >= 1){
    groups = floor(savings/15000)
    
    if (groups == 0){
      int = 1.80/100*savings
    }
    else if (groups == 1){
      int = 1.80/100*15000 + 1.95/100*(savings-15000)
    }
    else if (groups == 2){
      int = 1.80/100*15000 + 1.95/100*15000 + 2.10/100*(savings-30000)
    }
    else if (groups == 3){
      int = 1.80/100*15000 + 1.95/100*15000 + 2.10/100*15000 + 2.25/100*(savings-45000)
    }
    else if (groups >= 4){
      int = 1.80/100*15000 + 1.95/100*15000 + 2.10/100*15000 + 2.25/100*15000 + 3.83/100*max(savings-60000, 15000)
    }
  }
  
  int = int + ir/100*savings
  
  return (int)
}

ocbc <- function(salary, cc, balance, insure, invest, savings){
  if (is.na(salary)){
    salary = 0
  }
  if (is.na(cc)){
    cc = 0
  }
  if (is.na(balance)){
    balance = 0
  }
  if (is.na(insure)){
    insure = 0
  }
  if (is.na(invest)){
    invest = 0
  }
  if (is.na(savings)){
    savings = 0
  }
  
  int = 0
  if (salary >= 2000){
    if (savings <= 35000){
      int = int + 1.2/100*savings
    }
    else{
      int = int + 1.2/100*35000 + 1.5/100*max(savings-35000, 35000)
    }
  }
  
  if (cc >= 500){
    if (savings <= 35000){
      int = int + 0.3/100*savings
    }
    else{
      int = int + 0.3/100*35000 + 0.6/100*max(savings-35000, 35000)
    }
  }
  
  if (balance >= 500){
    if (savings <= 35000){
      int = int + 0.3/100*savings
    }
    else{
      int = int + 0.3/100*35000 + 0.6/100*max(savings-35000, 35000)
    }
  }
  
  if (insure + invest > 0){
    if (savings <= 35000){
      int = int + 0.6/100*savings
    }
    else{
      int = int + 0.6/100*35000 + 1.2/100*max(savings-35000, 35000)
    }
  }
  
  int = int + 1.0/100*min(balance, 10^6) + 0.05/100*savings
  
  if (savings >= 200000){
    int = int + 1.0/100*70000
  }
    
  return (int)
}

all <- function(salary, cc, insure, invest, home_loan, giro, balance, savings){
  dbs_int <- format(round(dbs(salary, cc, home_loan, insure, invest, savings)/12, 2), nsmall=2)
  ocbc_int <- format(round(ocbc(salary, cc, balance, insure, invest, savings)/12, 2), nsmall=2)
  uob_int <- format(round(uob(salary, cc, giro, savings)/12, 2), nsmall=2)
  
  mat <- matrix(c(dbs_int, ocbc_int, uob_int), nrow=1)
  data <- as.data.frame(mat)
  names(data) <- c("DBS Multiplier", "OCBC 360", "UOB One")
  
  return (data)
}
