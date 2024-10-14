+++
title = "Authoring great pull requests for easier code reviews"
date = "2021-07-06T18:06:55-04:00"
author = "Vivek Ranjan"
authorTwitter = "bcosynot" #do not include @
tags = ["communication", "cycle time", "process", "productivity", "pull requests"]
keywords = ["", ""]
description = "Tactics to make it easier for reviewers to provide you feedback, so you can get faster approvals and ship things quickly."
showFullContent = false
readingTime = true
hideComments = false
+++

Pull requests (PRs) are great for maintaining code quality, spreading knowledge about the codebase across a team, and
learning through each other's work.

But, they can be disruptive to the team's overall productivity because both the author and reviewers have to context
switch to provide feedback or respond to feedback.

---

### Software Engineer's Guide To Pull Requests
1. Authoring great pull requests for easier code reviews (this post)
2. [Guide to providing great feedback on pull requests](/posts/providing-great-feedback-on-pull-requests)

---

Over the last few years, I have implemented a few practices in my workflow that has helped me get faster and better
feedback in my PRs.

Making it easier to review your pull requests has multiple benefits:
1. You get quicker feedback from your colleagues - helping you finish your tasks faster ?
2. You get more interesting feedback, improving your code and learning ?
3. Makes you more likable because you made their job easier ?
4. Less context switching helps you save your mental energy ?

Let's jump in!

#### 1. 🗣 Talk through your ideas with a colleague before you start coding
This helps you get feedback before you even start coding.

You certainly do not have to do this if your changes are going to be pretty straightforward.

But, if you are making changes that require design decisions on your part, talk to a colleague about your ideas.
Get their feedback over a quick voice chat before you jump into coding.

Upon talking, you might realize that your original idea wasn't the optimal solution, or your colleague might suggest a
tweak that would make things better.


#### 2. 🐜 Keep it small

Keep the list of changes in your PR as small as possible because large PRs are
1. overwhelming to look at
2. force the reviewer to hold a lot of context about all the code that has been touched
3. and make it difficult for the reviewer to figure out what they should focus on at any given time

You can keep your PRs smaller by breaking down your task into smaller subtasks and staggering them.

If you are coding away faster than those small PRs are getting reviewed, you can chain them, so the destination of
your next PR is always pointing to the branch before it. A linked-list of PRs, if you will.

#### 3. 🤖 Lint, format and run static analysis before pushing

Take advantage of code formatting tools and standards to automate the trivial and boring stuff.

You should make them part of your CI/CD workflow and add them to your code editor, for quicker feedback. With automated
feedback in your code editor, you can take care of any issues that might arise, as they come up.

SonarLint and other linters are great examples of this, they should ideally be added to your code editor or local
"watch" builds so they throw warnings and issues as you code away.

This helps you write great code, but also saves your teammates' time they would have spent pointing out those issues.

#### 4. 📸 Provide screenshots or videos for UI changes

If your changes affect the user interface in any way then do attach some screenshots to the pull request. This provides
some useful context to the reviewers and also gives them more confidence in your changes.

They can also catch some minor issues you might have missed - that's a great advantage of having another pair of eyes
on your work!

#### 5. ‼️ Call out important or interesting changes

Some parts of your changes maybe more interesting or important than the others. Call them out in the form of inline
comments on the PR.

This will help reviewers understand where to better direct their attention and time.

If you are feeling generous, you could even call out the trivial parts of your changes so they know to spend less time
on those parts.

#### 6. 💬 Explain expected behavior through comments
I don't like leaving comments in code about what the code is doing because they can get outdated.

But, inline comments in PRs are useful for the duration of the PR and can be a great spot to let reviewers know the
expected functionality for a piece of code. That can help them verify if expectations match reality.

Of course your tests also help prove this, but tests are not always comprehensive or correct.

#### 7. 🔍 Go through it by yourself

Go through your PR yourself. The PR user interface can help you notice things you might have missed in your
code editor and fix them before someone else calls it out.

#### 8. 🔮 Anticipate feedback and requests for changes

After working with a team for a while you tend to get a sense of the types of feedback others might provide or the
types of changes they might request.

Anticipate that feedback and either incorporate them into your code or leave comments justifying why you are doing
things "your way" instead of "their way".

#### 9. 🏷️ Tag issue number/IDs in title or description

PR systems usually recognize issue numbers or IDs if they are preceded by # or a project identifier. They also tend to
create links to those issues or expand them to include the title/name of that issues.

It's a small thing but makes it easier for the reviewer to get more context on the changes.

#### 10. 📞 Take long discussions offline

If you see a discussion thread going past 4-5 comments, discuss it more in-person or over a quick call.

Async discussions like that tend to take more time, are more disruptive to both your workflows, and can be lacking in
nuance. Talking about it can help get the issue resolved more quickly with better understanding of each other.

---

What are some of your tips and practices?

These are some of the practices I have implemented and found helpful in my personal workflow.
Is there anything else I should be trying? What have you found helpful?
