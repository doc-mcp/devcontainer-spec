SUBMODULE_DIR := "./3rdparty/spec"

# Pull latest upstream, sync files, and build schemas
ci: update-submodule sync-files build-schemas
    @echo "Spec synchronization complete"

# Update the submodule to the latest upstream commit
update-submodule:
    @echo "Initializing and updating submodule..."
    git submodule update --init --remote {{SUBMODULE_DIR}}
    @echo "Submodule updated to latest upstream commit"

# Copy spec files from the submodule into docs/
sync-files:
    @echo "Syncing specification files from submodule..."
    mkdir -p ./docs/specification
    mkdir -p ./docs/schemas
    rsync -a --delete --exclude='.git' {{SUBMODULE_DIR}}/docs/ ./docs/specification/
    rsync -a --delete --exclude='.git' {{SUBMODULE_DIR}}/schemas/ ./docs/schemas/
    @echo "Files synced"

# Convert JSON schema files in docs/schemas/ to Markdown
build-schemas:
    @echo "Formatting JSON schema files to Markdown..."
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
    @echo "Schema build complete"
