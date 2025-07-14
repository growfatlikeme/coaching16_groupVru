# Automatically zip retrieveurl.py
data "archive_file" "lambda_package_retrieve" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda/retrieve-url" # Zips all Python files in 'lambda/retrieve-url/' folder
  output_path = "${path.module}/../lambda/retrieve-url.zip"
}

# Automatically Zip createurl Lambda Python Files
data "archive_file" "lambda_package_create" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda/create-url" # Zips all Python files in 'lambda/create-url/' folder
  output_path = "${path.module}/../lambda/create-url.zip"
}
