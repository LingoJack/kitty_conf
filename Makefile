SHELL := /bin/bash

KITTY_CONF := kitty.conf
LIGHT_THEME := theme-anthropic-light.conf
DARK_THEME := theme-anthropic-dark.conf

.PHONY: help current_dir push pull theme-light theme-dark theme-toggle

help: ## 显示帮助信息
	@echo "kitty config Makefile"
	@echo "============================================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

current_dir:
	@echo "Current directory: $$(pwd)"

push: current_dir
	@git add .\
	&& (git commit -m "新增了一些特性" || exit 0) \
	&& git push origin main

pull: current_dir
	@git pull origin main

# ============================================
# 主题切换
# ============================================

theme-light: ## 切换到亮色主题
	@current=$$(grep -E '^include .*theme-.*\.conf' $(KITTY_CONF) | head -1); \
	if echo "$$current" | grep -q '$(LIGHT_THEME)'; then \
		echo "already light"; \
	else \
		sed -i '' 's|^include .*theme-.*\.conf|include $(LIGHT_THEME)|' $(KITTY_CONF); \
		echo ">> switched to light theme"; \
	fi

theme-dark: ## 切换到暗色主题
	@current=$$(grep -E '^include .*theme-.*\.conf' $(KITTY_CONF) | head -1); \
	if echo "$$current" | grep -q '$(DARK_THEME)'; then \
		echo "already dark"; \
	else \
		sed -i '' 's|^include .*theme-.*\.conf|include $(DARK_THEME)|' $(KITTY_CONF); \
	fi
	@echo ">> switched to dark theme"

theme-toggle: ## 切换亮/暗主题
	@current=$$(grep -E '^include .*theme-.*\.conf' $(KITTY_CONF) | head -1); \
	if echo "$$current" | grep -q '$(LIGHT_THEME)'; then \
		sed -i '' 's|^include .*theme-.*\.conf|include $(DARK_THEME)|' $(KITTY_CONF); \
		echo ">> switched to dark theme"; \
	else \
		sed -i '' 's|^include .*theme-.*\.conf|include $(LIGHT_THEME)|' $(KITTY_CONF); \
		echo ">> switched to light theme"; \
	fi
