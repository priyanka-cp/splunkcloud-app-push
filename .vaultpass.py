#!/usr/bin/env python
import os
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--vault-id", type=str)
args = parser.parse_args()
print (args.vault_id)
if args.vault_id is None or args.vault_id == "None" or args.vault_id == "default":
	vault_pass_var = "VAULT_PASSWORD"
else:
	vault_pass_var = "VAULT_PASSWORD_" + args.vault_id

if os.environ.get(vault_pass_var) is not None and os.environ.get(vault_pass_var) != "":
    print (os.environ[vault_pass_var])
