# When you create an RDS instance, AWS always assigns a unique DNS name like:
# <random-identifier>.<random-hash>.<region>.rds.amazonaws.com
# The prefix (myappdb) usually comes from the identifier of the RDS instance.
# aws_db_instance.rds.address and aws_db_instance.rds.endpoint both point to the same DNS hostname for your RDS instance.

output "rds_endpoint" { value = aws_db_instance.rds.address } 



output "dynamodb_table" { value = aws_dynamodb_table.sessions.name }
