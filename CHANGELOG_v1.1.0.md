# v1.1.0: corrections to the economic analysis

Version 1.1.0 corrects the economic post-processing of Škegro et al., *Nature Communications* 17, 5980 (2026), and accompanies its Author Correction. The lifetime simulations, the raw data and Figs 1–3 are unchanged.

## Corrections

1. **Residual value counted once.** Version 1.0.0 subtracted the discounted residual value twice, once within the annual costs and again in the net present cost. The NPC equation in the Methods counts it once. The error favoured the reconfigurable pack in every scenario, by €492 at the baseline.
2. **Sampled inputs reach the cost model.** The sampled second-life thresholds and lifetime-extension draws were not passed on.
3. **Resale value of replacement packs** now includes the upfront cost factor (1 + ν).
4. **O&M split in replacement years.** A pack replaced at a whole year is now charged for that year as the old pack.
5. **Range of the added ohmic losses.** δ_loss is sampled in 0.5–3.5 % (baseline 2 %) instead of 1–5 % (baseline 3 %).

## Changed files

- `postprocessing/code/fig4-5/Fig4_5_SuppFig3_SuppFig4.m` and `SuppFig5.m`: corrections 1–5. Figures are now drawn in the light theme.
- `postprocessing/code/fig4-5/fig4_final_layout.m` (new) and `run_all_figures.m`: final axis limits and legend positions of Fig. 4.
- `simulation/README_simulation.md`: corrected cell-model references (documentation only).

## How to run

```matlab
cd postprocessing/code
run_all_figures
```

## Main results

| Quantity | Published | Corrected |
|---|---:|---:|
| Baseline ΔNPC (80 kWh LFP) [EUR] | 941 | 652 |
| Median ΔNPC, all scenarios [EUR] | 236 | 158 |
| Scenarios with a saving | 62.8 % | 61.1 % |
| Break-even pack energy [kWh] | 49.7 | 46.7 |
| Break-even annual distance [km] | 52,748 | 56,193 |
| Break-even upfront cost factor ν | 11.8 % | 11.0 % |
| Favourable region, ν below | 7.16 % | 5.62 % |
| Favourable region, L below [km] | 12,150 | 12,150 |
