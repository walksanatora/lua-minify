#!/usr/bin/env fish
echo "Minifying lua"
if [ -n "$GITHUB_WORKSPACE" ]
    cd "$GITHUB_WORKSPACE"
    echo $argv[1]
    for file in (echo $argv[1] | xargs find)
        echo "$file"
        luamin -f "$file" > "$file".tmp
        if luamin -f "$file" > "$file".tmp
            echo "Lua valid, renaming $file.tmp -> $file"
            if not set -q DRY_RUN then
                mv "$file.tmp" "$file"
            else
                echo "DRY RUN, file not changed"
            end
        else
            echo "FILE IS NOT LUA"
            cat "$file.tmp"
            rm "$file.tmp"
        end
    end
else
    echo "Not running in GH actions"
end

exit 0