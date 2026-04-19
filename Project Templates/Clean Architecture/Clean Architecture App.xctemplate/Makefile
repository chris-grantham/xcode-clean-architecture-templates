# Makefile — Clean Architecture scaffolding helpers
#
# ─────────────────────────────────────────────────────────────────────────────
# scaffold   Create boilerplate for a new feature across all architecture layers.
#
# Usage:
#   make scaffold FEATURE=<PascalCaseName>
#
# Example:
#   make scaffold FEATURE=UserProfile
#
# Generates inside this source directory:
#   Presentation/<Feature>/<Feature>View.swift
#   Presentation/<Feature>/<Feature>ViewModel.swift
#   Domain/<Feature>/<Feature>.swift
#   Data/<Feature>/<Feature>Repository.swift        ← Port + Adapter
#
# Because this project uses Xcode 15 filesystem-synchronized folders, the new
# files are picked up by Xcode automatically — no "Add Files to project…" step.
# ─────────────────────────────────────────────────────────────────────────────

SHELL    := /usr/bin/env bash
.DEFAULT_GOAL := help

# Resolve the directory containing this Makefile (the source root).
MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# ── Targets ───────────────────────────────────────────────────────────────────

.PHONY: scaffold
scaffold:
ifndef FEATURE
	$(error FEATURE is required. Usage: make scaffold FEATURE=UserProfile)
endif
	@chmod +x "$(MAKEFILE_DIR)Scripts/scaffold_feature.sh"
	@"$(MAKEFILE_DIR)Scripts/scaffold_feature.sh" "$(FEATURE)"

.PHONY: help
help:
	@echo ""
	@echo "Usage:"
	@echo "  make scaffold FEATURE=<PascalCaseName>   Scaffold a new feature across all layers"
	@echo ""
	@echo "Examples:"
	@echo "  make scaffold FEATURE=UserProfile"
	@echo "  make scaffold FEATURE=PaymentFlow"
	@echo "  make scaffold FEATURE=OnboardingStep"
	@echo ""
