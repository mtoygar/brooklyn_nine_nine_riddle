# Description

This is a "brain teaser" taken from Brooklyn Nine Nine S2E18. This repo solves the riddle with a TDD approach. Well, we can summarize the riddle as below.

- There are 12 people on an island.
- Only one of them has a different weight and we dont know s/he is heavier or lighter.
- Unfortunately, there are no scale on the island.
- But luckily, you have a seesaw at the hand.
- You could only use the seesaw 3 times.

Can you find the person with the different weight?

In case you want to hear the riddle from Captain Holt :point_right: https://www.youtube.com/watch?v=Cs-TGLxQfBM

# Why making a repo out of this?

Well, I enjoyed the problem while watching and later, started to think about a solution. After some time, I realized that I could approach it with TDD and constitute this repo for fun.

# How to test?

Assuming ruby-2.7.2 is already installed on your computer, you only need to run below commands.

- First, install dependencies with :point_down:
```bash
bundle install
```
- Second, run tests with :point_down:
```bash
bundle exec rubocop && rake test
```
