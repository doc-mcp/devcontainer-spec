SPEC_REPO := "https://github.com/devcontainers/spec.git"
TMP_DIR := "./tmp"

sync-spec:
    @echo "Downloading spec archive from $(SPEC_REPO_ARCHIVE)"
    rm -rf {{TMP_DIR}}
    mkdir -p {{TMP_DIR}}

    @echo "Cloning the spec repository from $(SPEC_REPO)"
    git clone --depth 1 {{SPEC_REPO}} {{TMP_DIR}}

    @echo "Copying the spec files to the current directory"
    mkdir -p ./docs/specification
    mkdir -p ./docs/schemas
    rsync -a --delete --exclude='.git' {{TMP_DIR}}/docs/ ./docs/specification/
    rsync -a --delete --exclude='.git' {{TMP_DIR}}/schemas/ ./docs/schemas/

    @echo "Formatting JSON files in docs/schemas to Markdown..."
    @for file in ./docs/schemas/*.json; do \
        if [ -f "$file" ]; then \
            filename=$(basename "$file"); \
            echo "# $filename" > "$file.tmp"; \
            echo "" >> "$file.tmp"; \
            echo '```json' >> "$file.tmp"; \
            cat "$file" >> "$file.tmp"; \
            echo '```' >> "$file.tmp"; \
            mv "$file.tmp" "${file%.json}.md"; \
            rm -f "$file"; \
        fi; \
    done

    @echo "Cleaning up temporary directory"
    rm -rf {{TMP_DIR}}

    @echo "Spec synchronization complete"
