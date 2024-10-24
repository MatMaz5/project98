include("structures.jl")
include("actions_cartes.jl")

function depart(n::Int64)
    if n == 2
        pioche = shuffle!(Paquet52())
        joueur1 = distribution(pioche, Paquet(Carte[]))
        joueur2 = distribution(pioche, Paquet(Carte[]))
        compteur = 0
        defausse = Paquet(Carte[])
    elseif n == 3
        pioche = shuffle!(Paquet52())
        joueur1 = distribution(pioche, Paquet(Carte[]))
        joueur2 = distribution(pioche, Paquet(Carte[]))
        joueur3 = distribution(pioche, Paquet(Carte[]))
        compteur = 0
        defausse = Paquet(Carte[])
    elseif n == 4
        pioche = shuffle!(Paquet52())
        joueur1 = distribution(pioche, Paquet(Carte[]))
        joueur2 = distribution(pioche, Paquet(Carte[]))
        joueur3 = distribution(pioche, Paquet(Carte[]))
        joueur4 = distribution(pioche, Paquet(Carte[]))
        compteur = 0
        defausse = Paquet(Carte[])
    else
        "Trop (ou pas assez) de joueurs : le jeu ne peut pas commencer." 
    end
end