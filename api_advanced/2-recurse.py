#!/usr/bin/python3
"""
Recursively queries the Reddit API for the titles of all hot posts
of a subreddit.
"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """Return a list of all hot post titles, or None if invalid."""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "linux:alu-api-advanced:v1.0 (by /u/alu_student)"}
    params = {"limit": 100, "after": after}
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code != 200:
        return None

    data = response.json().get("data", {})
    titles = [post.get("data", {}).get("title")
              for post in data.get("children", [])]
    hot_list = hot_list + titles
    after = data.get("after")

    if after is None:
        return hot_list if len(hot_list) > 0 else None
    return recurse(subreddit, hot_list, after)