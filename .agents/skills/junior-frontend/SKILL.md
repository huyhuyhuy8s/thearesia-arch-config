---
name: junior-frontend
description: Create and maintain React frontend components following project conventions. Use when the user wants to create new components, forms, pages, or modify existing React code. This skill enforces type-first exports, proper file structure, SCSS styling rules, and TanStack ecosystem patterns for this project.
---

# Junior Frontend Skill

This skill guides you through creating React frontend code that follows the project's conventions. Use this skill whenever working with React components, forms, hooks, or any frontend code in this project.

## Project Context

This is a React 19 + TypeScript project using:
- TanStack Router for navigation
- TanStack Query for data fetching
- TanStack Form for form management
- Zustand for global state
- SCSS for styling
- Zod for validation
- Material Symbols for icons

## File Structure

### Page-Scoped Components
```
src/routes/<role>/-components/<ComponentName>/
├── index.tsx
├── type.d.ts
├── style.scss
└── hooks/ (optional)
    └── use<Hook>.ts
```

### Reusable/Global Components
```
src/components/<ComponentName>/
├── index.tsx
├── type.d.ts
├── style.scss
├── components/<SubName>/
│   ├── index.tsx
│   └── style.scss
└── hooks/ (optional)
    └── use<Hook>.ts
```

## Type Export Convention (CRITICAL)

ALWAYS use `export` at the BEGINNING of each type definition. Never export at the end of the file.

**CORRECT:**
```typescript
export type TMyComponent = {
  className?: string;
};

export type TMyComponentProps = {
  data: TMyComponent;
  onChange: (value: string) => void;
};
```

**INCORRECT (NEVER do this):**
```typescript
type TMyComponent = { ... };
type TMyComponentProps = { ... };
export type { TMyComponent, TMyComponentProps };
```

### Props Type Naming Convention

- Main component data type: `T<ComponentName>` (e.g., `TSignUpForm`)
- Component props: `T<ComponentName>Props` (e.g., `TSignUpFormProps`)
- Hook props: `IUse<HookName>Props` (e.g., `IUseFormHandlerProps`)

## TSX Component Rules

### Entry & Export
- **Entry file**: always `index.tsx` — never `<ComponentName>.tsx`
- **Export**: always `export default` — never named exports

### Props
- Use `type` (not `interface`) for all types
- Props type: `T<n>Props` prefix
- Optional props go at the end with `?`

### Imports Order
```tsx
// 1. Internal subcomponents (./components/)
// 2. External libraries (react, tanstack-router, classnames)
// 3. Component-scoped hooks (./hooks/)
// 4. Shared hooks/stores (@/ alias)
// 5. Shared components (@/components/)
// 6. Constants/data/types
// 7. Style (always last): import "./style.scss"
```

### Classnames
- Always use `classnames` library — never string concatenation
- Hyphen (`-`) to connect segments, never double underscore (`__`)
- Example: `classnames("my-component", className)`

### Material Symbols
```tsx
<span className="material-symbols-rounded">icon_name</span>
```
Never use icon components or SVG imports for Material Symbols.

### Form Handlers
Never use `React.FormEvent` (deprecated). Use:
```tsx
const handleSubmit: React.EventHandler<React.SyntheticEvent<HTMLFormElement>> = (e) => {
  e.preventDefault();
  // handle submit
};
```

### Input Handlers
Use Lodash `debounce` for input `onChange` to prevent excessive re-renders:
```tsx
import _ from "lodash";

const handleChange = _.debounce((value: string) => {
  setValue(value);
}, 300);
```

### Links
Always use `CustomLink` component:
```tsx
import CustomLink from "@/components/CustomLink";

<CustomLink to="/route">Link text</CustomLink>
```

### Text & Typography
- Use semantic heading tags (`h1`–`h6`) or paragraph tags (`p`, `small`)
- Never use `<span>` for text with font-size needs
- Use typography classnames: `.bold`, `.semibold`, `.medium`, `.regular`

## SCSS Styling Rules

### Nesting
Always nest under parent using `&`:
```scss
.my-component {
  &-card { ... }
  &-input { ... }
}
```

### No `__` in selectors
Use `&-` instead of BEM `__` pattern.

### No `z-index`
Never set `z-index` — it breaks layout stacking.

### No strict fixed dimensions
Prefer `min-height`, `max-width`, `%`, `dvh`, `dvw`, `flex`, or `clamp()`.

### No `position: absolute`
Only use when element needs to escape parent's flow.

### Variables Only
Use tokens from `_variables.scss` and `_colors.scss`:
```scss
@use "@styles/colors" as *;
@use "@styles/variables" as *;
@use "@styles/functions" as *;
@use "@styles/mixins" as *;
```

### No font-family redeclaration
Global typography sets `font-family`.

### Responsive Units
Use `dvh`, `dvw`, `%`, `clamp()`, and `toRem()`.

### No source code comments
Never add comments inside SCSS files.

### Font-size & font-weight
Rely on semantic HTML tags and typography classnames.

## Form Creation Patterns

### With TanStack Form + Zod
```tsx
import { useForm } from "@tanstack/react-form";
import { zodValidator } from "@tanstack/zod-form-adapter";
import { z } from "zod";

const schema = z.object({
  email: z.string().email("Invalid email"),
  password: z.string().min(6, "Min 6 characters"),
});

const form = useForm({
  defaultValues: { email: "", password: "" },
  validatorAdapter: zodValidator(),
  validators: { onChange: schema },
  onSubmit: async ({ value }) => {
    // handle submit
  },
});
```

### With Plain React + Validation
```tsx
import { useState } from "react";
import { z } from "zod";

const schema = z.object({ ... });

const [formData, setFormData] = useState<TFormData>({ ... });
const [errors, setErrors] = useState<Record<string, string>>({});

const validate = () => {
  const result = schema.safeParse(formData);
  if (!result.success) {
    const newErrors: Record<string, string> = {};
    result.error.issues.forEach((issue) => {
      if (issue.path[0]) {
        newErrors[issue.path[0] as string] = issue.message;
      }
    });
    setErrors(newErrors);
    return false;
  }
  return true;
};
```

### Error Display
```tsx
{errors.fieldName && (
  <p className="component-error">{errors.fieldName}</p>
)}
```

## API Integration

### Calling Mutations
```tsx
import { useMutation } from "@tanstack/react-query";
import { graphqlClient } from "@/lib/graphql";
import { MUTATION } from "@/graphql/mutations";

const mutation = useMutation({
  mutationFn: async (variables) => {
    const response = await graphqlClient.request(MUTATION, variables);
    return response;
  },
  onSuccess: (data) => {
    // handle success
  },
});

// Usage
await mutation.mutateAsync({ data: { ... } });
```

### Fetching with Query
```tsx
import { useQuery } from "@tanstack/react-query";
import { graphqlClient } from "@/lib/graphql";
import { QUERY } from "@/graphql/queries";

const { data, isLoading, error } = useQuery({
  queryKey: ["key"],
  queryFn: async () => {
    const response = await graphqlClient.request(QUERY);
    return response;
  },
});
```

## Auth Patterns

### Store Usage
```tsx
import { useAuthStore } from "@/store/authStore";

const { user, isAuthenticated, setAuth, logout } = useAuthStore();
```

## Example: Creating a Sign Up Form

Given a requirement to create a sign-up form component:

1. Create folder: `src/routes/(auth)/-components/SignUpForm/`
2. Create `type.d.ts` with exports at beginning:
   ```typescript
   export type TSignUpForm = {
     firstName: string;
     lastName: string;
     email: string;
   };

   export type TSignUpFormProps = {
     data: TSignUpForm;
     errors: Record<string, string>;
     onChange: (field: keyof TSignUpForm, value: string) => void;
     onSubmit: () => void;
   };
   ```
3. Create `index.tsx` with component
4. Create `style.scss` with nested styles
5. Create `hooks/useSignUpForm.ts` with validation logic if needed

## When to Ask for Help

- Scene.tsx or Teacher.tsx modifications — ask first
- Adding new npm packages — ask first
- Backend API changes — confirm with user

## Summary

1. Types: `export` at BEGINNING, `T` prefix
2. Files: `index.tsx`, `type.d.ts`, `style.scss`
3. Classnames: use `classnames` library with `-` separator
4. SCSS: nest with `&`, use tokens only
5. Forms: can use TanStack Form or plain React + Zod
6. Always ask about Scene/Teacher changes and new packages