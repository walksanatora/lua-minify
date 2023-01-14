#!/usr/bin/env fish
echo "Minifying lua"
if [ -n "$GITHUB_WORKSPACE" ]
    cd "$GITHUB_WORKSPACE"
    echo $argv[1]
    for file in (echo $argv[1] | xargs find)
        echo "minify: $file"
        if luamin -f "$file" > "$file".tmp
            echo "valid, renaming $file.tmp -> $file"
            if not set -q DRY_RUN then
                mv "$file.tmp" "$file"
            else
                echo "DRY RUN, file not changed"
            end
        else
            echo "luamin failed"
            cat "$file.tmp"
            rm "$file.tmp"
        end
    end
else
    echo "Not running in GH actions"
    bash
end

exit 0