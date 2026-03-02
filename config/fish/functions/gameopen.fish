function gameopen
    set games_dir $HOME/Desktop/games

    function ListProjects
        set games_dir $HOME/Desktop/games
        echo ""
        echo Projects
        ls -l $games_dir | awk '{print "\033[36m  " $9 "\033[0m"}'
        echo ""
        functions -e ListProjects
    end

    if test (count $argv) -eq 0
        ListProjects
        return
    end

    set project_name $argv[1]
    set game_exists (ls $games_dir | grep -F $project_name | head -n 1)

    if test "$game_exists" != "$project_name"
        echo ""
        echo "Could not find project name $project_name"
        ListProjects
        return
    end

    cd $games_dir/$project_name
    clear
end
