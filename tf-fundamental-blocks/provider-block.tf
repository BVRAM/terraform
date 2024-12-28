/*

The provider Block: It's used to configure a specific provider. It tells Terraform which provider to use and how to authenticate with it.

    provider "<provider_name>" {
      # Configuration arguments for the provider
    }

What is a Provider?

In Terraform, a provider is a plugin that enables Terraform to interact with an external system. These systems can be:

Cloud providers: AWS, Azure, Google Cloud Platform (GCP), etc.
Other infrastructure platforms: Kubernetes, Docker, VMware vSphere, etc.
Software-as-a-Service (SaaS) providers: Datadog, PagerDuty, etc.

Providers define the resources and data sources that Terraform can manage for a given system. They handle the API interactions and translate Terraform configurations into API calls.

*/

provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR_ACCESS_KEY"       # Avoid hardcoding credentials
  secret_key = "YOUR_SECRET_KEY"       # Use environment variables or other secure methods
#  shared_credentials_file = "~/.aws/credentials" # No longer Preferred way
  profile = "my-aws-profile" # If using named profiles
}

provider "aws" {
  region = "us-east-1"
  alias = "east"
}

provider "aws" {
  region = "us-west-2"
  alias = "west"
}

resource "aws_instance" "example_east" {
  provider = aws.east # Use the "east" alias
  # ...
}


/*

Key Aspects of the provider Block:

1. Configuration Arguments: Each provider has its own set of configuration arguments. These arguments are used to configure the provider's behavior, such as:

    Authentication credentials: access_key, secret_key (AWS), client_id, client_secret, subscription_id (Azure), etc.
    Region or zone: region (AWS), location (Azure), zone (GCP).
    Endpoint URLs: For custom or non-standard API endpoints.
    Features: To enable specific provider features.

2. Authentication: It's strongly discouraged to hardcode credentials directly in your Terraform configuration files. Instead, use these more secure methods:

    Environment variables: Set environment variables like AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
    Shared credentials files: Use the AWS shared credentials file (~/.aws/credentials).
    Instance profiles or IAM roles (for AWS): When running Terraform on an EC2 instance, use an instance profile to grant the necessary permissions.
    Service principals (for Azure): Use service principals for authentication.
    Service accounts (for GCP): Use service accounts for authentication.

3. Multiple Provider Configurations (Aliases): You can define multiple configurations for the same provider using the alias argument. 
    This is useful for managing resources in different regions or accounts.


4. Meta-Arguments: Providers also support meta-arguments like version and alias:

    version: Used to specify version constraints for the provider (e.g., version = "~> 5.0"). This is now handled in the required_providers block inside the terraform {} block.

5. Implicit Provider Configuration: If you define resources that belong to a specific provider without explicitly configuring the provider block, 
    Terraform will try to use an implicit configuration. This means that the provider will try to authenticate using default methods (e.g. environment variables or credentials files). 
    However, it is always best practice to explicitly define your provider blocks.



Best Practices:

    Avoid hardcoding credentials.
    Use version constraints for providers in the required_providers block.
    Use aliases for multiple provider configurations.
    Keep provider configurations in the root module.

*/

#############################################################################

/*

Most used provider block attributes

1. Authentication:

    access_key and secret_key (AWS - Less Recommended)
    client_id, client_secret, tenant_id, subscription_id (Azure)
    credentials (GCP)
    token (AWS, Azure, GCP, Kubernetes, etc.)

2. Region/Location/Zone:

    region - AWS, Azure
    location - Azure
    zone - GCP

3. Features:
    Its common for azurerm provider

    provider "azurerm" {
        features {
            resource_group {
            prevent_deletion_if_contains_resources = true
            }
        }
    }

4. Default Tags:  automatically apply tags to all resources created by the provider.

    provider "aws" {
        region = "us-east-1"
        default_tags {
            tags = {
            Environment = "dev"
            ManagedBy   = "Terraform"
            }
        }
    }

5. Aliases: allows you to create multiple configurations for the same provider

    alias - aws,azure,gcp

6. Endpoint URL's : allow you to specify custom endpoint URLs. This is useful for interacting with non-standard API endpoints or for testing purposes.

    ((AWS - less common))

    provider "aws" {
        region                      = "us-east-1"
        s3_force_path_style         = true
        endpoints {
            s3 = "http://localhost:4566" # For local testing with LocalStack or similar
        }
    }

7. Insecure/Skip TLS Verification (Use with Extreme Caution):

    Some providers have options to disable TLS verification. This should only be used in development or testing environments and NEVER in production.

    (AWS - VERY STRONGLY DISCOURAGED for production):
    
    provider "aws" {
    region                      = "us-east-1"
    skip_credentials_validation = true
    insecure                    = true
    }
*/
