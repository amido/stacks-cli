# Runtime Configuration

Configuration for the CLI can be performed in several ways:

  - On the command line
  - Using environment variables
  - Using a configuration file (YAML or JSON)

Whe using a configuration file it is possible to setup more than one project.

## Settings

The following tables show the configuration options that are available at the root level and the command level.

### Global Options

The following options can be applied to any command within the Stacks CLI.

| Option | Environment Variable | Description | Default | Options |
|---|---|---|---|---|
| `-c`, `--config` | AMIDOSTACKS_CONFIG | Path to the configuration file to use | | |
| `-l`, `--loglevel` | AMIDOSTACKS_LOGLEVEL | Level of logging to be used | `info` | `debug`, `info`, `warning`, `error`, `fatal` |
| `-f`, `--logformat` | AMIDOSTACKS_LOGFORMAT | Output type of the logging | `text` | `text`, `json` |
| `--logcolur` | AMIDOSTACKS_LOGCOLOUR | State if logging should include colour | | |

### Scaffold options

| Option | Environment Variable | Description | Default | Options |
|---|---|---|---|---|
| `-n`, `--name` | AMIDOSTACKS_PROJECT_NAME | Name of the project to created | | |
| `--sourcecontrol` | AMIDOSTACKS_PROJECT_SOURCECONTROL_TYPE | Source control system to be used | `github` | |
| `-u`, `--sourcecontrolurl` | AMIDOSTACKS_PROJECT_SOURCECONTROL_URL | URL to the remote repository | | | 
| `--sourcecontrolref` | AMIDOSTACKS_PROJECT_SOURCECONTROL_REF | SHA reference or Tag to use to clone repository from. If a ref is supplied this is used over a release version package | | | 
| `-F`, `--framework` | AMIDOSTACKS_PROJECT_FRAMEWORK_TYPE | The framework that is to be used | | `dotnet`, `java`, `nodejs` |
| `-O`, `--frameworkoption` | AMIDOSTACKS_PROJECT_FRAMEWORK_OPTION | The sort of project to be created | | `webapi`, `cqrs`, `events` |
| `-V`, `--frameworkversion` | AMIDOSTACKS_PROJECT_FRAMEWORK_VERSION | The version of the Amido stacks project to use | `latest` | |
| `-P`, `--platformtype` | AMIDOSTACKS_PLATFORM_TYPE | Platform being deployed to | | `aks` |
| `-p`, `--pipeline` | AMIDOSTACKS_PIPELINE | Pipeline being used to build the project | | `azdo` |
| `-C`, `--cloud` | AMIDOSTACKS_CLOUD | Cloud platform being used | | `azure`, `aws`, `gcp` |
| `-R`, `--cloudregion` | AMIDOSTACKS_CLOUD_REGION | Region that the project will be deployed to | | |
| `-G`, `--cloudgroup` | AMIDOSTACKS_CLOUD_GROUP | Group in the cloud platform that will hold all the resources | | |
| `--company` | AMIDOSTACKS_BUSINESS_COMPANY | Name of your company or organisation | | |
| `-A`, `--area` | AMIDOSTACKS_BUSINESS_DOMAIN | Area of the company that is responsible for the project | | |
| `--component` | AMIDOSTACKS_BUSINESS_COMPONENT | Component of the overall project | | |
| `--tfstorage` | AMIDOSTACKS_TERRAFORM_BACKEND_STORAGE | Name of the storage account being used for the state | | |
| `--tfgroup` | AMIDOSTACKS_TERRAFORM_BACKEND_GROUP | Group name of the storage account | | |
| `--tfcontainer` | AMIDOSTACKS_TERRAFORM_BACKEND_CONTAINER | Container being used to store the data | | |
| `-d`, `--domain` | AMIDOSTACKS_NETWORK_BASE_DOMAIN | Domain root to be used for the projects | | | 
| `-w`, `--workingdirectory` | AMIDOSTACKS_DIRECTORY_WORKINGDIR | Directory that the projects should be created in | `${PWD}` | |
| `--tempdir` | AMIDOSTACKS_DIRECTORY_TEMPDIR | Directory to be used by Stacks for its temp files | System temp directory | |

## Configuration File

The following shows an example of a configuration file that can be passed to the command.

```yaml
project:
- name: tigerfest
  framework:
    type: dotnet
    option: webapi
    version: latest
  platform:
    type: aks    
  sourcecontrol:
    type: github
    url: https://github.com/russellseymour/my-new-project.git  

pipeline: azdo

cloud:
  platform: azure
  region: ukwest
  group: a-new-resource-group

business:
  company: MyCompany
  domain: core
  component: infra

terraform:
  backend:
    storage: adfsdafsdfsdf
    group: Stacks-Ancillary-Resources
    container: tfstate

network:
  base:
    domain: mydomain.com

stacks:
  dotnet:
    webapi: https://github.com/amido/stacks-dotnet-rjs
```

Note that when using the configuration file it is possible to specify multiple projects to be configured. This allows several projects to be setup at the same time, without having to run the command multiple times. Each project will be created within the specified working directory.

If this file was called `conf.yml` the command to run to consume the file would be:

```
.\stacks-cli.exe scaffold -c .\local\conf.yml
```