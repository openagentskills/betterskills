---
name: recipe-scaler
description: >-
  Scales recipes up or down for any serving count and suggests practical
  substitutions for missing ingredients. Use when the user wants to resize a
  recipe or asks what to use instead of an ingredient.
---

# Recipe Scaler & Substitutions

## Quick start

1. Get the recipe (user pastes it or describes it).
2. Get the target serving count (or the ingredient they're missing).
3. Scale or substitute, then note any technique adjustments.

## Scaling a recipe

### Steps

1. Identify original serving count.
2. Compute multiplier: `target ÷ original`.
3. Scale every ingredient by the multiplier.
4. Apply technique adjustments (see below).

### Ingredient table format

| Ingredient | Original | × Multiplier | Scaled |
|------------|----------|--------------|--------|
| flour | 2 cups | × 2.5 | 5 cups |
| eggs | 2 | × 2.5 | 5 |
| butter | 100 g | × 2.5 | 250 g |

Round to the nearest practical unit (e.g. 2.5 tsp not 2.47 tsp). Flag when an ingredient doesn't scale linearly (salt, leavening, spices).

### Technique adjustments

| Factor | Rule |
|--------|------|
| **Baking time** | Same temperature; check doneness 10–15 % earlier when scaling down, allow extra time when scaling up. Toothpick/internal-temp test beats the clock. |
| **Pan size** | Doubling a recipe ≠ doubling pan area. Suggest equivalent pan (e.g. two 9″ rounds instead of one 18″). |
| **Salt & spices** | Start at 75 % of scaled amount; taste and adjust. Avoid linear scaling for strong spices (cayenne, fish sauce). |
| **Leavening** | Scale at ~75 % when multiplier > 3×; too much baking powder causes collapse. |
| **Cooking fat** | Can reduce slightly when scaling up; pans retain more residual heat. |

## Substitutions

### Format

> **Missing:** [ingredient]
> **Substitutes:**
>
> 1. [Best sub] — [ratio] — [caveat]
> 2. [Second option] — [ratio] — [caveat]

### Common substitutions

| Missing | Sub | Ratio | Notes |
|---------|-----|-------|-------|
| Buttermilk (1 cup) | Milk + 1 tbsp white vinegar | 1:1 | Let sit 5 min to curdle |
| Buttermilk (1 cup) | Plain yogurt thinned with milk | 1:1 | Works well in baking |
| Eggs (1 large) | Flax egg (1 tbsp ground flax + 3 tbsp water) | 1:1 | Vegan; best in muffins/pancakes |
| Eggs (1 large) | ¼ cup unsweetened applesauce | 1:1 | Adds slight sweetness |
| Butter (1 cup) | Neutral oil | ¾ cup oil | Texture slightly denser |
| Butter (1 cup) | Coconut oil (solid) | 1:1 | Adds faint coconut flavour |
| All-purpose flour (1 cup) | Bread flour | 1:1 | Chewier result |
| All-purpose flour (1 cup) | Cake flour | 1 cup + 2 tbsp | Lighter, more tender |
| All-purpose flour (1 cup) | GF blend | 1:1 | Add ¼ tsp xanthan if blend lacks it |
| Heavy cream (1 cup) | Whole milk + 1 tbsp butter | 1:1 | Lower fat; won't whip |
| Sour cream (1 cup) | Plain Greek yogurt | 1:1 | Works in most baking and dips |
| Brown sugar (1 cup) | White sugar + 1 tbsp molasses | 1:1 | Mix well |
| Baking powder (1 tsp) | ¼ tsp baking soda + ½ tsp cream of tartar | 1:1 | Use immediately |
| Fresh herbs (1 tbsp) | Dried herbs | 1 tsp | Dried is more concentrated |

## Output format

```markdown
## Scaled recipe: [Name] — [original] → [target] servings

**Multiplier:** [n]×

### Ingredients

| Ingredient | Original | Scaled |
|------------|----------|--------|
| … | … | … |

### Technique notes
- [Any pan, time, or leavening adjustments]

---

## Substitutions

**Missing:** [ingredient]
1. [Sub 1] — [ratio] — [caveat]
2. [Sub 2] — [ratio] — [caveat]
```

## Example

**Input:** Pasta carbonara for 4 → scale to 10 servings.

**Multiplier:** 10 ÷ 4 = 2.5×

| Ingredient | Original | Scaled |
|------------|----------|--------|
| Spaghetti | 400 g | 1 kg |
| Eggs | 4 | 10 |
| Guanciale / pancetta | 150 g | 375 g |
| Pecorino Romano | 80 g | 200 g |
| Black pepper | 1 tsp | 2 tsp (taste first) |
| Salt (pasta water) | 1 tbsp | 2 tbsp |

**Technique notes:**

- Cook pasta in two large pots to maintain a rolling boil.
- Work in batches when tossing off heat — carbonara seizes if the pan cools too fast.
- Salt at 75 % of scaled amount and adjust.
