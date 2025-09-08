.PHONY: 00

00:
	uw fs copy -c 00-get-data.yaml

01:
	uw fs copy -c 01-get-data-parameterized.yaml --cycle 2025-09-08T00 --key-path data
