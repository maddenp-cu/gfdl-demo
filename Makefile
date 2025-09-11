CYCLE = 2025-09-09T00

TARGETS = 00 01 02 03 04

.PHONY: $(TARGETS)

all:
	$(info Targets are: $(TARGETS))

00:
	uw fs copy -c get-data.yaml

01:
	uw fs copy -c get-data-parameterized.yaml --cycle $(CYCLE) --key-path data

02:
	uw config realize -i ungrib.yaml -u user1.yaml -o 02/experiment.yaml
	uw ungrib run -c 02/experiment.yaml --cycle $(CYCLE)

03:
	uw config realize -i mpas-init.yaml -u user1.yaml -o 03/experiment.yaml
	SUBDIR=03 uw mpas_init provisioned_rundir -c 03/experiment.yaml --cycle $(CYCLE)

04:
	uw config realize -i mpas-init.yaml -u user2.yaml -o 04/experiment.yaml
	SUBDIR=04 uw mpas_init run -c 04/experiment.yaml --cycle $(CYCLE) --batch
