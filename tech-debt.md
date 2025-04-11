# Tech Debt - Last updated: 2025-04-09

## 1. TaskScreen Needs Error State Handling
- Plan: Use `Result<T>` pattern or enums

## 2. TaskViewModel lacks proper error Handling
- Scope: `onTaskCompletion`, `onPressingSave`
- What: Poor error handling by propogating error up the layers and avoided `Result<T>` or enums for State Error Handling
- Plan: Use `Result<T>` pattern during try catch statement

## 3. UiStateMapper buisness logic decouple
- Type: `refactor`
- Scope: `toDomainTaskModel`
- What: Remove buisness logic from UiStateMapper
- Plan: Dump the buisness logic in the ViewModel

## 4. Warning Dialog Sheet
- Type: `feat`
- Scope: `TaskModalSheet`
- What: Poor UX in case of accidental modal sheet dismissal
- Plan: Add a Confirmation Dialog pop asking for discarding

## 5. Disabling Save Button
- Type: `feat`
- Scope: `TaskModalSheet`
- What: Task gets saved even incase of empty title
- Plan: Disable save functionality if the title is empty