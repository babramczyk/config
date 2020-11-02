#!/bin/zsh

echo "🔀 Syncing home directories with the ones in this repo"

echo "⏳ Syncing ~/Alfred…"
cp -R ~/Alfred .
echo "⏳ Syncing ~/.config/karabiner/assets/complex_modifications…"
cp -R ~/.config/karabiner/assets/complex_modifications .config/karabiner/assets

echo "✅ All done!"