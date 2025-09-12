CYCLE = 2025-09-11T00

TARGETS = 00 01 02 03 04 05

.PHONY: $(TARGETS)

all:
	$(info Targets are: $(TARGETS))

00:
	uw fs copy -c get-data.yaml

01:
	uw fs copy -c get-data-parameterized.yaml --cycle $(CYCLE) --key-path data

02:
	uw config realize -i ungrib.yaml -u user.yaml -o 02/experiment.yaml
	uw ungrib run -c 02/experiment.yaml --cycle $(CYCLE)

03:
	uw config realize -i mpas-init.yaml -u user.yaml -o 03/experiment.yaml
	SUBDIR=03 uw mpas_init provisioned_rundir -c 03/experiment.yaml --cycle $(CYCLE)

04:
	uw config realize -i mpas-init.yaml -u user.yaml -o 04/experiment.yaml
	SUBDIR=04 uw mpas_init run -c 04/experiment.yaml --cycle $(CYCLE) --batch

05:
	CYCLE=$(CYCLE) uw config realize -i workflow.yaml -u workflow-user.yaml -o 05/experiment.yaml --total
	uw fs copy -c 05/experiment.yaml --key-path data
	uw rocoto realize -c 05/experiment.yaml -o 05/rocoto.xml
	uw rocoto iterate --cycle $(CYCLE) --database 05/rocoto.db --rate 5 --task mpas_init --workflow 05/rocoto.xml
