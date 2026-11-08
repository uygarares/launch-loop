# Attacker and defender duel

Read this file only when the user asks for a duel. All golden rules and safety rules of `SKILL.md` still apply, especially: never exploit anything, never run attack code, never contact a live system, never try found passwords or keys.

> Experimental. These rules have not yet been compared with the default scan on real projects. Say so to the user.

## The two ideas behind it

1. **Findings are tested, not reviewers.** Every finding gets its own duel and is judged on evidence. A reviewer who is knocked out keeps its confirmed findings in the final report.
2. **The tournament decides who looks deeper.** Reviewers whose findings hold up go on to search the parts that are still unexplored.

## Before you start

1. **Narrow the scope** to risky code: login, sessions, money, encryption, file handling, anything that takes input from outside, automation files. Use the whole project only if the user insists.
2. **Choose the size.** 16 reviewers (four rounds) or 8 reviewers (three rounds). Default to 8 unless the user asks for 16.
3. **Estimate.** Let S be the tokens for one read of the scope (lines x 12). Round 1 costs about N x S, where N is the number of reviewers. All later rounds together cost about N/2 x S. Each finding duel costs about 9,000 tokens; expect about 2 findings per reviewer. Give the size (Small, Medium, Large) and say plainly: "A duel costs about 5 to 10 times more than a normal scan." Never state a money amount as a fact.
4. **Budget.** Ask whether the user wants a limit. If it is reached, stop and report what was done so far.
5. Wait for a clear yes.

## Strategy cards

Each reviewer gets one card and keeps it. With 8 reviewers, use cards 1 to 8.

1. **Outside attacker.** Someone with no account and only public access.
2. **Malicious user.** Someone with a normal account who wants more than they should get.
3. **Input to danger.** Trace outside input to queries, commands, files, pages, and templates.
4. **Secrets hunter.** Keys, passwords, and tokens in files and in git history.
5. **Login and sessions.** How identity is checked, kept, and ended.
6. **Permissions.** Where the code decides who may do what, and where it forgets to.
7. **Automation.** CI/CD workflows, install and build scripts.
8. **Embedded pages and bridges.** WebViews and anything that lets a page call app code.
9. **Cryptography.** Keys, random numbers, hashing, encryption modes.
10. **Files and paths.** Uploads, downloads, file names chosen by users.
11. **Error and log leaks.** What errors and logs reveal.
12. **Dependencies.** Outside packages and how they are used.
13. **AI and agents.** Outside text that could give orders to an assistant, tools that act without asking.
14. **Privacy.** Personal data: where it goes and who can see it.
15. **Timing.** Two requests at once, actions in the wrong order.
16. **Resource abuse.** Very large input, endless loops, costly calls someone could trigger.

## Round 1: search

- Every reviewer reads the scope with its card, on its own, and writes at most 10 findings: file, line, quoted code, one sentence on the risk, and a severity guess.
- If parallel helpers are not available, run the reviewers one after another.

## Pooling

The judge merges findings with the same file and root cause, records who found each one, and numbers them.

## Finding duels

For each finding:

- **Attacker:** describes, in plain words, how the problem could be misused. The description must be a chain with three links, each backed by a quote from the code:
  1. **Entry:** who can reach this code, and how.
  2. **Path:** how their input or action travels to the weak spot.
  3. **Harm:** what they could read, change, delete, or take over.

  The attacker **never writes working attack code, real payloads, or step-by-step instructions for a real system**. A short plain description such as "a file name with `../` in it" is enough.
- **Defender:** argues that the chain is broken. Every protection must be quoted from the code (for example a check, an escape, a permission). An assumed protection does not count.
- If possible, neither role is played by the reviewer who found the problem.

**The judge decides with these rules:**
1. Open each quoted file and line. A quote that does not exist is ignored.
2. Only quoted evidence counts. Length, confidence, and style do not count.
3. Read the defender first for even-numbered findings and the attacker first for odd-numbered ones.
4. Verdict:
   - **Confirmed:** all three links of the chain are backed by real code, and no quoted protection breaks the chain. Set the severity with the rules in `SKILL.md`, Step 4.
   - **Rejected:** a quoted protection breaks the chain, or the attacker's evidence does not exist.
   - **Unclear:** a link depends on something the code does not show (for example server settings or how the app is deployed). Unclear findings are never deleted. They go to the "Needs a human check" list.
5. Write one sentence explaining each verdict.

## Scores

- Confirmed High: +3. Confirmed Medium: +2. Confirmed Low: +1.
- Unclear: 0.
- Rejected: -1.
- When several reviewers found the same finding, each of them gets the points.

## Elimination

1. Pair the remaining reviewers by card number: 1 with 2, 3 with 4, and so on.
2. The higher score wins. If equal: more confirmed High findings, then fewer rejected findings, then the lower card number.
3. Winners go to the next round. Losers stop searching, but their confirmed and unclear findings stay in the report.

## Later rounds: go deeper

- Focus list: files nobody reported on, files with Unclear findings, and the important files from `PROJECT_MAP.md` if it exists.
- Give each winner the confirmed findings so far and the instruction: "Look deeper with your card. What did the first round miss?"
- New findings go through pooling and duels again. Scores add up.
- **Stop early** when a round finds nothing new that is confirmed, when the budget is reached, or when one reviewer is left. The last one is the **champion**.

## Final check and report

1. The judge opens every confirmed finding one last time and checks the quotes.
2. Report in plain words, only to the user in the conversation (never in a public place):
   - **Confirmed findings:** the table from `SKILL.md`, Step 5, with the attack chain in one plain sentence, plus who found it and in which round.
   - **Needs a human check:** each Unclear finding, with the missing link named.
   - **Rejected:** a short list with the one-sentence reason.
   - **Tournament:** rounds, pairs, scores, and the champion card.
   - **Cost:** the estimate and, if it can be measured, the real size. Otherwise "not measured".
   - What was not checked.
   - "This is not a full security audit. It was done by reading code, not by testing a running system. For a serious product, ask a security professional."
