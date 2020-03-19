# testJA

API method descriptions for mobile clients https://apiecho.cf/doc/
- Create screen with signup/login actions obtain `access_token`
- Using `access_token`, fetch text for any supported locale (described in Models paragraph)
Some calls to the service endpoints must be authorized to retrieve results. This is done by a bearer token sent in the http request header. An example header is represented below:
Authorization : Bearer <access_token>
Request without a token will always get a 401 Unauthorized response.
- Count occurrence of each character in the text that you received before
- Display results using any UI component (for example UITableView or UICollectionView)
