+++
title = "Guide to providing great feedback on pull requests"
date = "2022-07-24T20:17:06-04:00"
author = "Vivek Ranjan"
authorTwitter = "bcosynot" #do not include @
tags = ["communication", "cycle time", "process", "productivity", "pull requests"]
keywords = ["", ""]
description = "Things I have learned over the years to keep in mind for providing useful and actionable feedback on pull requests in GitHub, Bitbucket, Gitlab, etc."
showFullContent = false
readingTime = true
hideComments = false
+++

---

### Software Engineer's Guide To Pull Requests
1. [Authoring great pull requests for easier code reviews](/posts/quicker-feedback-pull-requests/)
2. Guide to providing great feedback on pull requests (this post)

---

Why should you bother with having a system to provide great feedback on pull requests? Because
1. you are not a monster and want to be helpful to your colleagues?  ?
2. you want to build that sweet, sweet social capital ?  (this is different than playing politics by the way)
3. you want to make providing feedback quick and easy for yourself ✨
4. it helps your team deliver high quality software ?

Here's my process/system/guide/set of practices for providing great feedback on pull requests that I have developed over the years after reviewing around 1000 of them. Yes, I checked that number. No, they weren't all PRs I authored and approved for my side projects.

{{< image src="indie-hacker-approving-pr.jpg" position="center" >}}

This is going to split up into two parts.

Part one is some general things to keep in mind while reviewing a pull request.

Part two is a step-by-step process to provide thorough feedback.

---

## Part 1: Some things to keep in mind

### 0. 🕸 Don't ignore the spidey sense tingles

You might feel your "spidey sense start to tingle" while reviewing some code, without quite knowing what's wrong with it.

You develop this sense with experience so don't ignore that feeling and try to dig in and think more about why that's
happening. Ask your colleagues for help if you need to.

### 1. ✌️Be extra kind, polite, and thoughtful!

Sure, yeah, I know it's easy to think your colleagues should be thick skinned and be ready to receive all kinds of
feedback, and in an ideal world how you deliver your feedback shouldn't matter, and of course, your coworkers know that you are not a big meanie.

But... a lot of people DO [struggle](https://twitter.com/pcwalton/status/1555322353432666113) with disassociating
feedback on their work outputs from themselves.

First, the author of the pull request is putting themselves out there to be scrutinized which isn't always fun.

Second, feedback in pull requests is usually provided through text where you lose a lot of nuances and your tone might
not come across how you intend.

So,  take the additional 10-20 seconds to be extra kind, polite, and thoughtful in your comments and feedback.

### 2. ⚖️ Ask for clarifications instead of passing judgment

"Why don't you just.....?" No. Why don't you just jump off a cliff?!

"Why didn't you....?" No. Why didn't you jump off a cliff yet?!

Honestly those two questions should be banned from the human vocabulary. Avoid those phrases, please!


Operate under the assumption that the PR author has probably thought through different approaches before they arrived at
the one they wrote. If you have a particular solution or approach in mind, ask them if they have thought about it or
alternatively why that approach might not work.

So, instead of “Why don’t you just….?” or “Why didn’t you….?”, ask “Have you considered….? I think that might be a
better approach here because…. What do you think?”

Also, spots where you ask for clarifications might be good candidates for the author to add code comments. Future
readers might have the same questions.

### 3. 💬 Provide reasons behind your comments

This builds on the previous two points in helping you to  not be an asshole.

Nobody likes a know-it-all who drops a statement like a widely known fact and walks away. Provide some reasoning behind
your comments. You will eventually have to explain anyway, so save everyone some time?

### 4. 👀 Understand context and constraints behind changes

Ideally, the PR isn't the first time you are seeing or hearing about these changes. By that I mean there has already
been some discussion about the work, the approach being taken, and you were expecting to see this PR.

If this is the first time you are hearing about it, make sure to ask for all relevant context and details so you can
provide your feedback with the full picture. Not just the what, but also the why.

{{< tweet user="bcosynot" id="1558084239106637825" >}}
{{< tweet user="EddieHinkle" id="1558084684030124033" >}}

Equally important is to understand the constraints folks are working under -  time is usually the biggest one to watch
out for, but infrastructure, language/framework/stack capabilities, and product/business decisions are some other
constraints to keep in mind.

A lot of the points I make in my [guide for authoring great pull requests](/posts/quicker-feedback-pull-requests) basically
boil down to "provide more context" - so sharing that with your colleagues might be helpful because you will be able to
provide better feedback. Is that selfish of you (and me)? Yes. Does it help everyone in the long run? Also yes.

### 5. 🙏 Be appreciative and thankful

Pull requests don't have to be all doom and gloom. Try to bring some joy and positivity to the pull requests.

Some things to appreciate -
1. an elegant solution - “This is a really cool way to solve the problem!”
2. good documentation - “This documentation is going to super helpful for the team”
3. interesting refactor - “Interesting, love how you changed how this was implemented!”
4. something new to you that you learned - - “I had no idea, this is neat!”
5. code deletion - “Less code to maintain, win!”
6. or just appreciate them for putting in the hard work! - “Thanks for putting in the hard work, this was very needed”

{{< tweet user="curiouslychase" id="1405163424036786186" >}}

Personally, this is one area I can do a lot better in, so let me know if you have ideas around this!

### 6. 💪 Be actionable and non-vague

Don't leave folks scratching their heads on the other end.

Make it explicit whether you are needing changes or just suggesting them. If you are just sharing general information, mention that. If you want to share something for future thought, let that be known.

Just don't leave a comment that's not actionable or doesn't make its intention clear.

### 7. ⛏ Skip the nitpicks

Honestly, it's terribly annoying. Go touch some grass instead.

Hot take aside, this might be the norm for some teams and folks might be OK with it. In which case - you do you.

But, skip it if you start working with new teammates or when you interact with other teams.

### 8. 📞 Move longer discussions offline

I mentioned this in the guide for authoring great pull requests, so I'm just going to paste that here again.

    If you see a discussion thread going past 4-5 comments, discuss it more in-person or over a quick call.

    Async discussions like that tend to take more time, are more disruptive to both your workflows, and can be lacking in nuance. Talking about it can help get the issue resolved more quickly with better understanding of each other.

    - Me, in "Authoring great pull requests for easier code reviews"

---

## Part 2: step-by-step process for providing great feedback

With the general stuff out of the way, let's get into the nitty-gritty specifics of reviewing pull requests. Think of it as a checklist of things to do while you go through a pull request.

### 0. 🧠 Understand context

I mentioned this earlier in "Understand context and constraints behind changes". This is important so it bears
repeating again! In my opinion, you are doing both yourself and the PR author a disservice by not having a good
understanding of what's changing and why.

### 1. 🔂 Start with a quick once-over

Go through the changes once, without looking for anything specific, just to get an overall sense of the changes.

### 2. ✍️ Get syntax and formatting stuff out of the way (if necessary)

Auto format and lint your code where possible!

But, if you don't have linters or formatters already setup in your CI/CD pipelines, its best to get this out of the
way as soon as possible.

Go through the code and let folks know about syntax and formatting anomalies.

Also, add some tasks to your backlog to add those linters and formatters while you are thinking about it.

### 3. 🧑‍🎨 Get an understanding of design and data flow

This isn't always necessary for smaller PRs, but for larger ones it makes sense to get a general sense of design and
data flow before you start getting into the nitty gritty of the code.

This is where you can start providing general feedback about the design.

### 4. 🔍 Now go file by file

And for each file check the following:

1. Functionality/obvious bugs - code works as expected
2. Placement - are the files and code blocks where they need to be? Could they be better suited somewhere else?
3. Code duplication and generalization - Could code be made more DRY?
4. Readability - does the code make sense and is easy to read?
5. Documentation - comments, where appropriate, are present
6. Non-obvious bugs - these are harder to spot, but huge win for the team if these are caught
7. Coding standards - is everything on the up and up with your organization's coding standards?
8. Tests - are they present? do they meet the coverage standards of your organization? do they cover the essential parts?
9. Check if your spidey senses tingle at any time and don't ignore them!

---

#### What are some of your tips and practices?

Thanks for reading all the way to the end! I hope this was helpful and I would love to know what practices have worked for you in providing great feedback in pull requests
