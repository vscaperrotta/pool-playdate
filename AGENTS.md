# Project Instructions

This project is both a Playdate game and a study space for algorithms implemented in Lua and C. Keep algorithm learning visible in the code and connect examples to useful game behavior where practical.

## Learning and Algorithm Design

- Prefer implementing the algorithm being studied directly instead of hiding it behind a library call. Use libraries for game, SDK, and platform plumbing; explain any library call that replaces a central algorithm.
- Keep algorithm logic separate from Playdate input, rendering, and other side effects so it can be understood and reused on its own.
- For each substantial algorithm, make its purpose, inputs, outputs, assumptions, and important invariant clear through names and concise English comments or a short explanation near the implementation.
- State time and space complexity when introducing or materially changing an algorithm. Keep the explanation consistent with the actual implementation.
- Use small, concrete examples when they make a data structure or algorithm easier to follow. Prefer examples drawn from the game where that does not obscure the concept.
- Favor a clear baseline before adding optimizations. Preserve a simpler version when comparing approaches is part of the learning goal.
- Review code quality by asking whether each abstraction, branch, and state value is needed; remove complexity that does not help the game or the learning objective.

## Code Style

- Write comments in English.
- Prefer pure functions: do not mutate input parameters or global state. Keep necessary game-state changes at clear boundaries.
- Follow DRY, KISS, and YAGNI. Check for existing logic before adding another implementation.
- Use explicit types wherever the language supports them, including C declarations, function parameters, and return types. In Lua, use clear names and document expected input and return shapes where they are not obvious.
- Put imports and includes at the top of each file.
- Keep functions focused on one task. Avoid mode flags that make one function switch between unrelated behaviors.
- Match the existing repository style and keep changes scoped to the request.

## Error Handling

- Report failures explicitly; do not silently ignore errors.
- Use clear, actionable error messages and the most specific error mechanism available in the language or SDK.
- Fix the cause of an error rather than masking its symptoms.
- Use structured logging fields when the logging system supports them.

## Tooling and Validation

- Inspect the repository and any applicable nested `AGENTS.md` files before making changes.
- Keep dependencies in project configuration and install them in project environments, not globally.
- Respect the existing validation strategy. Do not add tests by default; when validation is needed, prefer the smallest meaningful integration, end-to-end, or smoke check. Avoid mocks when a real check is practical.
- Do not run tests or validation commands unless requested or needed to verify a change.
- Do not revert unrelated user changes.

## Documentation

- Treat clear code and concise comments as the primary documentation.
- Add or update separate documentation only when the concept cannot be expressed clearly in code; avoid duplicating instructions.
- Keep documentation focused on current behavior and concepts, not a changelog of edits.
