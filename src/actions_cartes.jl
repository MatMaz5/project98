include("structures.jl")


# Mélanger le paquet :
using Random
function Random.shuffle!(paquet::Paquet)
    shuffle!(paquet.cartes)
    paquet
end


# Tirer une carte :
function Base.pop!(paquet::Paquet) 
    pop!(paquet.cartes)
end


# Supprimer une carte à un endroit donné :
function Base.splice!(paquet::Paquet, index::Int64)
    splice!(paquet.cartes, index)
end


# Ajouter une carte :
function Base.push!(paquet::Paquet, carte::Carte) 
    push!(paquet.cartes, carte)
    paquet 
end


# Création des mains des joueurs (et  de la pioche en conséquence) :
function distribution(paquet::Paquet)
    joueur = Paquet(Carte[])
    for i in 1:5
        joueur = push!(joueur, pop!(paquet))
    end
    joueur
end

# Actions sur le compteur :
function jouer(compteur::Int64, joueur::Paquet,  index::Int64, defausse::Paquet, pioche::Paquet)
    carte = joueur.cartes[index]
    rg = carte.rang
    if 1 <= rg <= 10
        compteur += rg
    elseif rg == 11
        compteur += 0
    elseif rg == 12
        compteur -= 10
    elseif rg == 13
        compteur = 70
    end
    splice!(joueur, index)
    push!(joueur, pop!(pioche))
    push!(defausse.cartes, carte)
    if compteur%10 == 0
        print(Int(compteur/10), " GAGES !")
        compteur
    elseif compteur >= 98
        "perdu"
    else
        compteur
    end
end


# Lancement du jeu :
