// Settings
#define kClearAvatarCacheDefaultsKey @"clearAvatarCache"
#define kLastReadingDateURLDefaultsKeyPrefix @"lastReadingDate:"
#define kLoginDefaultsKey @"username"
#define kTokenDefaultsKey @"token"

// API
#define kLoginParamName @"login"
#define kTokenParamName @"token"

// tables
#define kRepositoryCellIdentifier @"RepositoryCell"
#define kFeedEntryCellIdentifier @"FeedEntryCell"
#define kIssueCellIdentifier @"IssueCell"
#define kUserCellIdentifier @"UserCell"
#define kNetworkCellIdentifier @"NetworkCell"
#define kBranchCellIdentifier @"BranchCell"
#define kCommentCellIdentifier @"CommentCell"

// URLs
#define kUserGithubFormat @"http://github.com/%@"
#define kRepositoryGithubFormat @"http://github.com/%@/%@/tree/master"
#define kIssueGithubFormat @"http://github.com/%@/%@/issues#issue/%d"
#define kUserFeedFormat @"https://github.com/%@.atom"
#define kNewsFeedFormat @"https://github.com/%@.private.atom?token=%@"
#define kActivityFeedFormat @"https://github.com/%@.private.actor.atom?token=%@"
#define kRepoFeedFormat @"https://github.com/feeds/%@/commits/%@/%@"
#define kPrivateRepoFeedFormat @"https://github.com/feeds/%@/commits/%@/%@"
#define kUserXMLFormat @"https://github.com/api/v2/xml/user/show/%@"
#define kAuthenticateUserXMLFormat @"https://github.com/api/v2/xml/user/show/%@?login=%@&token=%@"
#define kUserReposFormat @"https://github.com/api/v2/xml/repos/show/%@"
#define kUserWatchedReposFormat @"https://github.com/api/v2/xml/repos/watched/%@"
#define kUserSearchFormat @"https://github.com/api/v2/xml/user/search/%@"
#define kUserFollowingFormat @"https://github.com/api/v2/json/user/show/%@/following"
#define kUserFollowersFormat @"https://github.com/api/v2/json/user/show/%@/followers"
#define kRepoXMLFormat @"https://github.com/api/v2/xml/repos/show/%@/%@"
#define kRepoSearchFormat @"https://github.com/api/v2/xml/repos/search/%@"
#define kPublicRepoCommitsJSONFormat @"https://github.com/api/v2/json/commits/list/%@/%@/%@"
#define kPublicRepoCommitJSONFormat @"https://github.com/api/v2/json/commits/show/%@/%@/%@"
#define kPrivateRepoCommitsJSONFormat @"https://github.com/api/v2/json/commits/list/%@/%@/%@"
#define kPrivateRepoCommitJSONFormat @"https://github.com/api/v2/json/commits/show/%@/%@/%@"
#define kRepoWatchFormat @"https://github.com/api/v2/xml/repos/watch/%@/%@?token=%@"
#define kRepoUnwatchFormat @"https://github.com/api/v2/xml/repos/watch/%@/%@?token=%@"
#define kUserFollowFormat @"https://github.com/api/v2/xml/user/follow/%@?token=%@"
#define kUserUnfollowFormat @"https://github.com/api/v2/xml/user/unfollow/%@?token=%@"
#define kRepoBranchesJSONFormat @"https://github.com/api/v2/json/repos/show/%@/%@/branches"
#define kRepoIssuesXMLFormat @"http://github.com/api/v2/xml/issues/list/%@/%@/%@"
#define kRepoIssueXMLFormat @"https://github.com/api/v2/xml/issues/show/%@/%@/%d"
#define kOpenIssueXMLFormat @"https://github.com/api/v2/xml/issues/open/%@/%@"
#define kEditIssueXMLFormat @"https://github.com/api/v2/xml/issues/edit/%@/%@/%d"
#define kIssueCommentsJSONFormat @"https://github.com/api/v2/json/issues/comments/%@/%@/%d"
#define kIssueCommentJSONFormat @"https://github.com/api/v2/json/issues/comment/%@/%@/%d"
#define KUserFollowingJSONFormat @"https://github.com/api/v2/json/user/show/%@/following"
#define kNetworksFormat @"https://github.com/api/v2/xml/repos/show/%@/%@/network"
#define kFollowUserFormat @"https://github.com/api/v2/json/user/%@/%@"
#define kWatchRepoFormat @"https://github.com/api/v2/json/repos/%@/%@/%@"
#define kIssueToggleFormat @"https://github.com/api/v2/json/issues/%@/%@/%@/%d"

// Issues
#define kIssueStateOpen @"open"
#define kIssueStateClosed @"closed"
#define kIssueToggleClose @"close"
#define kIssueToggleReopen @"reopen"
#define kIssueTitleParamName @"title"
#define kIssueBodyParamName @"body"
#define kIssueCommentCommentParamName @"comment"

// Images
#define kImageGravatarMaxLogicalSize 44

// Following/Watching
#define kFollow @"follow"
#define kUnFollow @"unfollow"
#define kWatch @"watch"
#define kUnWatch @"unwatch"

// KVO
#define kResourceLoadingStatusKeyPath @"loadingStatus"
#define kResourceSavingStatusKeyPath @"savingStatus"
#define kUserLoginKeyPath @"login"
#define kUserGravatarKeyPath @"gravatar"
