# Deep review: the tournament

Read this file only when the user asks for a deep review. All golden rules and safety rules of `SKILL.md` still apply.

> Experimental. These rules have not yet been compared with the default review on real projects. Say so to the user.

## The two ideas behind it

1. **Findings are tested, not reviewers.** Every finding gets its own duel and is judged on evidence. A reviewer who is knocked out keeps its confirmed findings in the final report. Nothing true is thrown away because of who found it.
2. **The tournament decides who looks deeper.** Reviewers whose findings hold up go on to search the parts that are still unexplored. Weak strategies stop early, which saves cost.

## Before you start

1. **Narrow the scope.** Offer to run the deep review only on risky files: login, money, encryption, deleting data, permissions. Use the whole project only if the user insists.
2. **Choose the size.** 16 reviewers (four rounds) or 8 reviewers (three rounds, cheaper). Default to 8 unless the user asks for 16.
3. **Estimate.** Let S be the tokens for one read of the scope (lines x 12). Round 1 costs about N x S, where N is the number of reviewers. All later rounds together cost about N/2 x S. Each finding duel costs about 9,000 tokens; expect about 2 findings per reviewer. Add these up and give the size (Small, Medium, Large). Tell the user plainly: "A deep review costs about 5 to 10 times more than a normal review." Never state a money amount as a fact.
4. **Budget.** Ask whether the user wants a limit. If the limit is reached, stop, and report what was done so far.
5. Wait for a clear yes.

## Strategy cards

Each reviewer gets one card and keeps it for the whole tournament. With 8 reviewers, use cards 1 to 8.

1. **Backwards from failure.** Imagine the worst result for a user, then look for the code that could cause it.
2. **Edge cases first.** Empty, very large, negative, missing, duplicate, or strange input.
3. **Follow the data.** Trace values from where they enter to where they are stored, shown, or sent.
4. **Error paths.** What happens when a file is missing, the network fails, or a call throws.
5. **Attacker mindset.** How could someone misuse this on purpose?
6. **First-time user.** What would surprise or hurt someone using it for the first time?
7. **State and saved data.** What can get out of sync, be lost, or be saved twice?
8. **Recent changes.** What did the latest changes break or forget?
9. **First principles.** What must always be true here? Find where it is not.
10. **Timing.** Two things at once, slow responses, actions in the wrong order.
11. **Configuration.** Settings, environment, build and release files.
12. **Boundaries and permissions.** Who is allowed to do what, and where is that checked?
13. **Resource limits.** Memory, time, very long lists, very large files.
14. **What is not tested.** Important behavior with no test.
15. **Dependencies.** How the code uses outside packages and services.
16. **Confusing code.** Places so hard to read that a bug could hide there.

## Round 1: search

- Every reviewer reads the whole scope with its card, on its own. Reviewers do not see each other's work.
- Each reviewer writes at most 10 findings. Each finding has: file, line, quoted code, one sentence on what goes wrong, and a severity guess.
- If parallel helpers are not available, run the reviewers one after another and finish each list before starting the next.

## Pooling

The judge merges findings that point to the same file and the same root cause. It records every reviewer who found each one. Each finding gets a number.

## Finding duels

For each finding in the pool:

- **Prosecutor:** argues that the problem is real.
- **Defender:** argues that the code is safe or the problem cannot happen. Every protection the defender names must be quoted from the code. A protection that is only assumed does not count.
- If possible, neither role is played by the reviewer who found the problem. If helpers are not available, write the prosecutor's case completely before writing the defender's case.

**The judge decides with these rules:**
1. Open each quoted file and line. A quote that does not exist is ignored.
2. Only quoted evidence counts. Length, confidence, and style do not count.
3. A claim about how the program behaves while running, which cannot be seen in the code, does not count as proof for either side.
4. To avoid order bias, read the defender first for even-numbered findings and the prosecutor first for odd-numbered findings.
5. Verdict:
   - **Confirmed:** the problem is shown by real code and no quoted protection stops it. Set its severity with the rules in `SKILL.md`, Step 4.
   - **Rejected:** a quoted protection stops it, or the prosecutor's evidence does not exist.
   - **Unclear:** both sides have real evidence and the answer depends on something the code does not show. Unclear findings are never deleted. They go to the "Needs a human check" list.
6. Write one sentence explaining each verdict.

## Scores

- Confirmed High: +3. Confirmed Medium: +2. Confirmed Low: +1.
- Unclear: 0.
- Rejected: -1. This discourages guessing.
- When several reviewers found the same finding, each of them gets the points.

## Elimination

1. Pair the remaining reviewers by card number: 1 with 2, 3 with 4, and so on.
2. The higher score wins. If the scores are equal: more confirmed High findings wins, then fewer rejected findings, then the lower card number.
3. Winners go to the next round. Losers stop searching, but their confirmed and unclear findings stay in the report.

## Later rounds: go deeper

- The focus list for the next round is: files where nobody reported anything, files with Unclear findings, and the important files from `PROJECT_MAP.md` if it exists.
- Give each winner the list of findings already confirmed, so it does not repeat them, and the instruction: "Look deeper with your card. What did the first round miss?"
- New findings go through pooling and duels exactly as before. Scores add up across rounds.
- **Stop early** when a round produces no new confirmed finding, when the budget is reached, or when one reviewer is left.
- The last reviewer standing is the **champion**. Its card is the strategy that worked best on this code.

## Final check and report

1. The judge opens every confirmed finding one last time and checks the file, line, and quote.
2. Report, in plain words:
   - **Confirmed findings:** the table from `SKILL.md`, Step 5, plus who found each finding and in which round.
   - **Needs a human check:** each Unclear finding with one sentence from each side.
   - **Rejected:** a short list with the one-sentence reason, so the user can see what was dismissed.
   - **Tournament:** each round, the pairs, their scores, and the champion card.
   - **Cost:** the estimate given at the start, and the real size if it can be measured. If it cannot, say "not measured".
   - What was not checked.
   - "This is not a full security audit."
3. If `PROJECT_MAP.md` exists, you may propose adding the champion card under a new line "Best deep review strategy". Show it and save only after approval.
