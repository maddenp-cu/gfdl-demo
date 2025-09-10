CYCLE = 2025-09-09T00

TARGETS = 00 01 02 03 04

.PHONY: $(TARGETS)

all:
	$(info Targets are: $(TARGETS))

00:
	uw fs copy -c 00-get-data.yaml

01:
	uw fs copy -c 01-get-data-parameterized.yaml --cycle $(CYCLE) --key-path data

02:
	uw config realize -i 02-ungrib.yaml -u user.yaml -o 02/experiment.yaml
	uw fs link -c 02/experiment.yaml --cycle $(CYCLE) --key-path data
	uw ungrib run -c 02/experiment.yaml --cycle $(CYCLE)

03:
	uw config realize -i 03-mpas-init.yaml -u user.yaml -o 03/experiment.yaml
	uw mpas_init provisioned_rundir -c 03/experiment.yaml --cycle $(CYCLE)

04:
	uw config realize -i 04-mpas-init.yaml -u user.yaml -o 04/experiment.yaml
	uw mpas_init run -c 04/experiment.yaml --cycle $(CYCLE) --batch
