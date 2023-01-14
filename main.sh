#!/usr/bin/env fish
echo "Minifying lua"
if [ -n "$GITHUB_WORKSPACE" ]
    cd "$GITHUB_WORKSPACE"
    pwd
    for file in (find $argv)
        echo "$file"
        luamin -f "$file" > "$file".tmp
        if luamin -f "$file" > "$file".tmp
            echo "Lua valid, renaming $file.tmp -> $file"
            mv "$file.tmp" "$file"
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