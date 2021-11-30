# Confluent Replicator Configuration
This project performs tasks on provisioned instances of the Confluent Replicator connector.

## Ansible
Ansible is used to run all tasks in this project. Tags can be used to control which tasks are run.

## Tags
Only the tasks assigned to the tags you specify are run.
These are:
- `apply-config`, applys the configuration of the Confluent Replicator connectors.
- `plan-config`, displays the configuration of the Confluent Replicator connectors.

The `check` tag will cause Ansible to dry-run tasks.

### Examples
`./provisioning/run.sh -e dev -c shared -p confluent-replicator-config`  
`./provisioning/run.sh -e dev -c shared -p confluent-replicator-config -t v`  
`./provisioning/run.sh -e dev -c shared -p confluent-replicator-config -t apply-config,check`  