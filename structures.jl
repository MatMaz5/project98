# Cartes d'un jeu de 52 basique :
struct Carte 
    rang :: Int64
    couleur :: Int64 
    function Carte(rang::Int64, couleur::Int64) 
        @assert(1 ≤ rang ≤ 13, "problème de rang")
        @assert(1 ≤ couleur ≤ 4, "problème de couleur")
    new(rang, couleur)
    end 
end

rangs = (:As, 2, 3, 4, 5, 6, 7, 8 , 9, 10, :V, :D, :R)
couleurs = (:♥, :♦, :♠, :♣)

function Base.show(io::IO, carte::Carte)
   print(io, rangs[carte.rang], couleurs[carte.couleur])
end


# Paquet complet :
struct Paquet 
    cartes :: Array{Carte, 1} 
end

function Paquet52() 
    paquet = Paquet(Carte[])
    for couleur in 1:4
        for rang in 1:13
            push!(paquet.cartes, Carte(rang, couleur))
        end
    end
    paquet
end

function Base.show(io::IO, paquet::Paquet) 
    for carte in paquet.cartes
        print(io, carte, " ")
    end
    println()
end
