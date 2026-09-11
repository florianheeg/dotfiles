# AWS credentials for Audi Bedrock (stored securely in macOS Keychain)
export VW_KUMS_ID=$(security find-generic-password -s "audi-bedrock-kums-id" -a "kums-id" -w 2>/dev/null || true)
export AWS_ROLE_ARN=$(security find-generic-password -s "audi-bedrock-arn-role" -a "arn-role" -w 2>/dev/null || true)
