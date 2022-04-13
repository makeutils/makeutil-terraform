# terraform command
TERRAFORM?=terraform

ifndef stack
stack:=$(shell $(TERRAFORM) workspace show)
endif

# configuartion files for terraform
VARFILES?=-var-file=$(stack).tfvars

info:
	@echo :: using workspace $(stack)
	@echo :: $(shell $(TERRAFORM) version)

init:
	$(TERRAFORM) init

clean:
	rm -rf .terraform

reinit: clean init

switch:
	$(TERRAFORM) workspace select $(stack) || ($(TERRAFORM) workspace new $(stack) && $(TERRAFORM) workspace select $(stack))

$(addprefix select., $(basename $(wildcard *-[0-9].tfvars) $(wildcard *-[0-9][0-9].tfvars))):
	$(eval STACKNAME=$(lastword $(subst ., ,$@)))
	$(MAKE) switch stack=$(STACKNAME)

validate:
	$(TERRAFORM) validate $(VARFILES)

get:
	$(TERRAFORM) get

plan: get
	$(TERRAFORM) plan $(VARFILES) -out tfplan

apply:
	$(TERRAFORM) apply tfplan

destroy:
	$(TERRAFORM) destroy $(VARFILES)

refresh:
	$(TERRAFORM) refresh $(VARFILES)
