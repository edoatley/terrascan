# Terrascan Alternatives
- [Terrascan Alternatives](#terrascan-alternatives)
  - [Introduction](#introduction)
  - [KICS](#kics)
    - [Usage](#usage)
    - [Initial thoughts](#initial-thoughts)
  - [tfsec / trivy](#tfsec--trivy)
    - [Usage](#usage-1)
    - [Initial thoughts](#initial-thoughts-1)
  - [Checkov](#checkov)
    - [Usage](#usage-2)
    - [Initial thoughts](#initial-thoughts-2)

## Introduction

In this follow on article I look at some other tooling 

## KICS

### Usage

KICS stands for Keeping Infrastructure as Code Secure and has a web page here: https://docs.kics.io/latest/getting-started/

To try it out I ran the following:

```bash
docker pull checkmarx/kics:latest
path_to_host_folder_to_scan=/Users/edoatley/source/terrascan/terraform
docker run -t -v ${path_to_host_folder_to_scan}:/path checkmarx/kics:latest scan -p /path -o "/path/"
```

This seemed to work quite easily and the output started with:

```output
Scanning with Keeping Infrastructure as Code Secure v2.1.3

Preparing Scan Assets: Done                                                                                                                          
Executing queries: [---------------------------------------------------] 100.00%
```

each issue was detailed with output like this:

```output 
VPC FlowLogs Disabled, Severity: MEDIUM, Results: 1
Description: Every VPC resource should have an associated Flow Log
Platform: Terraform
CWE: 778
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/f83121ea-03da-434f-9277-9cd247ab3047

        [1]: ../../path/main.tf:1

                001: resource "aws_vpc" "main" {
                002:   cidr_block           = var.vpc_cidr_block
                003:   instance_tenancy     = "default"

```

and a summary is printed at the end:

```output
Results Summary:
CRITICAL: 0
HIGH: 0
MEDIUM: 3
LOW: 2
INFO: 11
TOTAL: 16

Generating Reports: Done  
```

Furthermore a `results.json` file is created with all the details that looks like [this](./resources/kics-results.json)

### Initial thoughts

I quite like KICS it was easy to use and produces good output. It is also open source and has a GitHub repository at [Checkmarx/kics](https://github.com/Checkmarx/kics). Furthermore it is simple to integrate into your CICD pipelines with good instructions available, for example, [here for GitHub actions](https://github.com/Checkmarx/kics/blob/master/docs/integrations_ghactions.md). Finally it also supports various other IaC tools in addition to terraform such as AWS CloudFormation, Azure Bicep, Pulumi, Helm, Ansible etc. 

## tfsec / trivy

### Usage

`tfsec` is another tool that is easy to use. It has recently been acquired by Aqua and is moving underneath the `trivy` banner (which is notable as a container scanning tool)

I tried both `tfsec` and `trivy` images to scan starting with `tfsec`:

```bash
docker run --rm -it -v "$(pwd)/terraform:/terraform" aquasec/tfsec /terraform
```

This produced a useful set of results I saved [here](./resources/tfsec-results.txt). I then tried the same
scan with `trivy`:

```bash
docker run --rm -it -v "$(pwd)/terraform:/terraform" aquasec/trivy config /terraform
```
This produced an identical (I believe) set of results I saved [here](./resources/trivy-results.txt)

### Initial thoughts

The scan results appear decent catching all the security related issues but did miss some INFO level information KICS found such as:

> It's considered a best practice for an EC2 instance to use an EBS optimized instance. This provides the best performance for your EBS volumes by minimizing contention between Amazon EBS I/O and other traffic from your instance

Perhaps it is possible to achieve this with configuration but it was not obvious.

## Checkov

### Usage

Again Checkov can be run fairly easily with:

```bash
docker run --rm -it -v "$(pwd)/terraform:/terraform" --workdir "/terraform" bridgecrew/checkov --directory /terraform
```

This produced a set of results I saved [here](./resources/checkov-results.txt). 

### Initial thoughts

The scan results appear well described with good reference documentation links