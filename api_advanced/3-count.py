#!/usr/bin/python3
"""
Recursively queries the Reddit API and prints a sorted count of
given keywords found in the titles of all hot posts of a subreddit.
"""
import requests


def count_words(subreddit, word_list, after=None, counts=None):
    """Print the keyword counts sorted by count, then alphabetically."""
    if counts is None:
        counts = {}

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "linux:alu-api-advanced:v1.0 (by /u/alu_student)"}
    params = {"limit": 100, "after": after}
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code != 200:
        return

    data = response.json().get("data", {})
    words = [word.lower() for word in word_list]
    for post in data.get("children", []):
        title = post.get("data", {}).get("title", "").lower().split()
        for word in words:
            found = title.count(word)
            if found > 0:
                counts[word] = counts.get(word, 0) + found

    after = data.get("after")
    if after is not None:
        return count_words(subreddit, word_list, after, counts)

    for word, total in sorted(counts.items(), key=lambda x: (-x[1], x[0])):
        print("{}: {:d}".format(word, total))