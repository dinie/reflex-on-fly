# reflex-on-fly
GH Actions driven continuous deoployment of Reflex App.


## Application Architecture

*Backend:* Deployed to fly.io

*Frontend:* Served from Cloudflare Pages

*Database:* Uses Fly.io Postgres


### Prerequisites

The following must be derived ahead of using the repo's Continuous Deployment process.

In this Github repo, go to Settings -> Secrets and enter the following:

`FLY_API_TOKEN` - You must have a valid fly.io account and run the flyctl tool locally.

`CLOUDFLARE_ACCOUNT_ID` - Identifies your Cloudflare Account

`CLOUDFLARE_API_TOKEN` - This must be scoped to include Edit permissions for the Account's Cloudflare Pages. If you wish to reuse this same token for provisioning Cloudflare DNS, the token scope should include Zone:DNS edit permissions.


#### Provisioning Cloudflare Pages

This should be setup before any application CI/CD runs. Use Terraform to spin up Cloudflare Pages resources. You must provide the following variables to the Terraform run:

`cloudflare_token` - As described earlier

`cloudflare_account_id` - As described earlier

`cloudflare_zone_id` - Cloudflare DNS Zone id

`cloudflare_project_name` - Use this to identify your Cloudflare pages project. It will be used as the subdomain on which your pages app is served from, e.g. `${cloudflare_project_name}.yourdomain.com`. Note that the same value should be passed in as variable to the _deploy_backend_ github workflow.


### Provisioning Tigris Object Data store
We must create an object store (bucket) to host the frontend of the application.
See [here](https://www.tigrisdata.com/docs/sdks/fly/) for a step by step guide.
First, create a public bucket with a name that matches the CNAME of the host you will serve the app from, e.g.

```bash
fly storage create images.myapp.com --public
```

Optionally the bucket can be given a custom domain:

```bash
fly storage update images.myapp.com --custom-domain images.myapp.com
```

