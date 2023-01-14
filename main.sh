#!/usr/bin/env fish
echo "Minifying lua"
if [ -n "$GITHUB_WORKSPACE" ]
    cd "$GITHUB_WORKSPACE"
    pwd
    for file in (find $argv)
        echo "$file"
        luamin -f "$file" > "$file".tmp
        if cat "$file.tmp" | grep "Error: failed to minify. Make sure the Lua code is valid" >/dev/null
            echo "$file had .lua but was infact not lua"
            rm "$file.tmp"
        else
            echo "Lua valid, renaming $file.tmp -> $file"
            mv "$file.tmp" "$file"
        end
    end
else
    echo "Not running in GH actions"
end

exit 0