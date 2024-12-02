include("prop_compteur.jl")


import Random
import JLD

using Random
using JLD


# Mélanger le paquet :
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


# Jouer une carte :
function jouer(compteur::Base.RefValue{Int64}, joueur::Paquet,  index::Int64, defausse::Paquet, pioche::Paquet)
    effet_cartes(compteur, joueur, index)
    splice!(joueur, index)
    push!(joueur, pop!(pioche))
    push!(defausse.cartes, joueur.cartes[index])
    etat_compteur(compteur)
end