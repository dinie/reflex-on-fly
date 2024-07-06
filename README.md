# reflex-on-fly
GH Actions driven continuous deoployment of Reflex App.


## Application Architecture

*Backend:* Deployed to fly.io
*Frontend:* Served from Tigris Object store
*Database:* Uses Fly.io Postgres

### Prerequisites

The following must be derived ahead of using Continuous Deployment.
In this Github repo, go to Settings -> Secrets and enter the following:
`FLY_API_TOKEN` - You must have a valid fly.io account and run the flyctl tool locally.


`AWS_ACCESS_KEY_ID` - This is the AWS-like credential generated when you initiate the Tigris Object store
`AWS_SECRET_ACCESS_KEY` - As above


#### Initiating Tigris Object Store

We must create an object store (bucket) to host the frontend of the application.
See [here](https://www.tigrisdata.com/docs/sdks/fly/) for a step by step guide.
First, create a public bucket with a name that matches the CNAME of the host you will serve the app from, e.g.

```bash
fly storage create myapp.com --public
```

Next the bucket must be given a custom domain:

```bash
fly storage update myapp.com --custom-domain myapp.com
```

