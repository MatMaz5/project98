include("structs.jl")


# Effets de chaque carte sur le compteur :
function effet_cartes(compteur::Base.RefValue{Int64}, joueur::Paquet,  index::Int64)
    carte = joueur.cartes[index]
    rg = carte.rang
    if 1 <= rg <= 10
        compteur[] += rg
    elseif rg == 11
        compteur[] += 0
    elseif rg == 12
        compteur[] -= 10
    elseif rg == 13
        compteur[] = 70
    end
end


# "État" du compteur :
function etat_compteur(compteur::Base.RefValue{Int64})
    if compteur[]%10 == 0
        println(Int(compteur[]/10), " gages à donnés ! ", )
        println("Compteur = ", compteur[])
    elseif compteur[] >= 98
        println("Perdu !")
    else
        println("Compteur = ", compteur[])
    end
end