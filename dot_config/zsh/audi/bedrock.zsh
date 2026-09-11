# Audi Bedrock (AWS credentials loaded from macOS Keychain via ~/.config/zsh/audi/keychain.zsh)
audi-bedrock() {
  if [[ -z "$VW_KUMS_ID" || -z "$AWS_ROLE_ARN" ]]; then
    echo "Error: AWS credentials not found in Keychain." >&2
    echo "Run: security add-generic-password -s audi-bedrock-kums-id -a kums-id -w <value>" >&2
    echo "and: security add-generic-password -s audi-bedrock-arn-role -a arn-role -w <value>" >&2
    return 1
  fi
  awstoken --proxy --timeout 240 --user "$VW_KUMS_ID" --output json --role "$AWS_ROLE_ARN"
}
