TARGETS = 00 01 02

.PHONY: $(TARGETS)

all:
	$(info Targets are: $(TARGETS))

00:
	uw fs copy -c 00-get-data.yaml

01:
	uw fs copy -c 01-get-data-parameterized.yaml --cycle 2025-09-08T00 --key-path data

02:
	uw config realize -i 02-ungrib.yaml -u user.yaml -o 02/experiment.yaml
	uw fs link -c 02/experiment.yaml --cycle 2025-09-08T00 --key-path data
	uw ungrib run -c 02/experiment.yaml --cycle 2025-09-08T00
