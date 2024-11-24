# Vérifier si le bon joueur est prêt à jouer :
function bon_joueur()
    press = readline()
    while press != "O"
        println("Essayez de nouveau.")
        press = readline()
    end
end


# Vérifier si l'indice de carte/le nombre de joueur entré est bien un nombre :
function nombre()
    try
        nb = parse(Int64,readline())
        nb
    catch
        @warn "La valeur entrée n'est pas un nombre. Réessayez."
        nombre()
    end
end