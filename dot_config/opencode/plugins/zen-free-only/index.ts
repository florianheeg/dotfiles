// OpenCode Zen: hide every paid model so only free models are selectable.
// Scoped to the "opencode" provider only — all other providers keep their models.
//
// A model counts as free when every cost tier has input and output priced at 0.
// Models without pricing info (empty `cost`) are left untouched.
import { Plugin } from "@opencode/plugin"

export default Plugin.define({
  id: "zen-free-only",
  async setup(ctx) {
    await ctx.model.transform((editor) => {
      const models = editor.list("opencode")
      for (const model of models) {
        const tiers = model.cost ?? []
        const paid = tiers.length > 0 && tiers.some((tier) => tier.input > 0 || tier.output > 0)
        if (!paid) continue
        editor.update("opencode", model.id, (draft) => {
          draft.enabled = false
        })
      }
    })
  },
})