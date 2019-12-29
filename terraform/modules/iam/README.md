# IAM

## IAM user

### Access key

You shoud prepare gpg-key by base64

1. You make gpg-key
    - `gpg --gen-key`
    - Real name: `<user-name>`
    - Email address: `<user@examle.com>`
    - And you put passphrase on tty

2. output gpg-key as a file
    - `gpg -o ./<user-name>.public.gpg  --export <user-name>`
    - `gpg -o ./<app-user>.private.gpg --export-secret-key <app-user>`
      - And you put passphrase here

3. Encode to base64
    - `cat <user-name>.public.gpg | base64 | tr -d '\n' > <user-name>.public.gpg.base64`
    - confirm `cat <user-name>.public.gpg.base64`
    - "*****" is replaced the key in environments/*/main.tf

4. Terraform is executed

5. Confirm output
    - `terraform output id`
    - `terraform output terraform output secret | base64 -D | gpg -r <user-name>`