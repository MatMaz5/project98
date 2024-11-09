using Random
using JLD

   
   ## Création des cartes :
struct Carte 
    rang :: Int64
    couleur :: Int64 
end
# Créer une structure de carte renseignée par un couple d'entiers.


rangs = (:As, 2, 3, 4, 5, 6, 7, 8 , 9, 10, :V, :D, :R)
couleurs = (:♥, :♦, :♠, :♣)

function Base.show(io::IO, carte::Carte)
   print(io, rangs[carte.rang], couleurs[carte.couleur])
end
# Base.show : fonction show de base (au cas où elle est modifiée ailleurs).
# io :: IO : multiple dispatching : permet de gérer l'affichage automatiquement.
# io (dans print) : associer le show et le print.
# Cette fonction permet d'associer la structure de la carte à sa "vraie" valeur.



    ## Création du paquet de cartes :
struct Paquet 
    cartes :: Vector{Carte}
end
# Créer une structure pour le paquet de cartes.

function Paquet52() 
    paquet = Paquet(Carte[])
    for couleur in 1:4 
# Sélectionne la couleur de la carte.
        for rang in 1:13 
# Sélectionne le rang de la carte.
            push!(paquet.cartes, Carte(rang, couleur)) 
# push! : ajoute le couple carte sélectionné à la liste de cartes du paquet.
        end
    end
    paquet
end

# Le Paquet est pour le moment une liste de cartes.

function Base.show(io::IO, paquet::Paquet) 
    for carte in paquet.cartes
        print(io, carte, " ")
    end
    println()
end
# Cette fonction permet de créer un affichage pour les cartes de la liste stocker dans le Paquet.



    ## Effets sur le paquet :
        # Mélanger le paquet :
function Random.shuffle!(paquet::Paquet)
    shuffle!(paquet.cartes)
    paquet
end
# Importe et formate la fonction "shuffle!" pour l'adapter au paquet.


        # Sortir une carte :
function Base.pop!(paquet::Paquet) 
    pop!(paquet.cartes)
end



        # Supprimer une carte :
function Base.splice!(paquet::Paquet, index::Int64)
    splice!(paquet.cartes, index)
end
# Supprime la carte d'indice index du paquet et l'affiche.


        # Ajouter une carte :
function Base.push!(paquet::Paquet, carte::Carte) 
    push!(paquet.cartes, carte)
    paquet 
end
# Rajoute une carte à la fin de paquet sélectionné.


        # Créer les mains des joueurs en début de partie :
function distribution(paquet::Paquet)
    joueur = Paquet(Carte[])
    for i in 1:5
        joueur = push!(joueur, pop!(paquet))
    end
    joueur
end
# La fonction créer un "joueur" et lui transfert 5 cartes d'un "paquet".
# Elle retourne ensuite la main du joueur -> pb pour après : tt le monde voit toutes les mains des joueurs.
# A la fin de la fonction, les 5 dernières cartes du "paquet" n'apparaissent donc plus (puisqu'elles sont dans la main du joueur).
# Le reste du "paquet" sert alors de pioche.



########################################################################################################
#########################################  SECTION BROUILLON.  #########################################
########################################################################################################



    # Actions sur le compteur :
function jouer_br(compteur::Int64, joueur::Paquet,  index::Int64, defausse::Paquet, pioche::Paquet)
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
# Pb : le compteur ne change pas : un Int64 est immuable -> Base.RefValue{Int64} pour avoir un nombre variable.
# Trop complexe : il faut la remanier pour la réduire, grâce à des "sous-fonctions".



# Lancement du jeu :
struct Jeu98
    paquet :: Paquet
    defausse :: Paquet
    joueur1 :: Paquet
    joueur2 :: Paquet
    joueur3 :: Paquet
    compteur :: Base.RefValue{Int64}
end

# "struct" : pas bien designé -> nombre de joueurs fixe et pas appelable avec des indices.
# Plutôt utiliser un "Dict".

function mise_en_place_br()
    print("Mise en place du jeu.")
    pioche = shuffle!(Paquet52())
    defausse = Paquet(Carte[])
    joueur1 = distribution(pioche)
    joueur2 = distribution(pioche)
    joueur3 = distribution(pioche)
    compteur = Ref(0)
    return Jeu98(pioche, defausse, joueur1, joueur2, joueur3, compteur)
end


function partie_br()
    c = 4
    jeu = mise_en_place(c)
    valeur_compteur(compteur)
    while jeu.compteur[] < 98
        print("Quelle carte voulez-vous jouer ?")
        indice = readline()
        # joueur1 joue
        if jeu.compteur[] < 98
            # joueur2 joue
            if jeu.compteur[] < 98
                # joueur3 jouer
            end
        end
    end
    print("Perdu !")
end

# Fonction à finir



########################################################################################################
#######################################  - RÉVISION DE LA FIN -  #######################################
########################################################################################################



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

function etat_compteur(compteur::Base.RefValue{Int64})
    if compteur[]%10 == 0
        println(Int(compteur[]/10), " GAGES ! ", )
        println("Compteur = ", compteur[])
    elseif compteur[] >= 98
        println("Perdu !")
    else
        println("Compteur = ", compteur[])
    end

end


function jouer(compteur::Base.RefValue{Int64}, joueur::Paquet,  index::Int64, defausse::Paquet, pioche::Paquet)
    effet_cartes(compteur, joueur, index)
    splice!(joueur, index)
    push!(joueur, pop!(pioche))
    push!(defausse.cartes, joueur.cartes[index])
    etat_compteur(compteur)
end

function mise_en_place(nb_jr)
    Jeu_98 = Dict()
    Jeu_98["pioche"] = shuffle!(Paquet52())
    Jeu_98["defausse"] = Paquet(Carte[])
    Jeu_98["compteur"] = Ref(0)
    if 2 <= nb_jr <= 5
        for i in 1:nb_jr
            Jeu_98[i] = distribution(Jeu_98["pioche"])
        end
        println("Nombre de joueurs correct. Lancement du jeu.")
    else
        println("Nombre de joueurs incorrect. Veuillez changez.")
        nb_jr = parse(Int64,readline())
    end
    Jeu_98
end
# Créer la structure du jeu avec une pioche, une défausse, un compteur et des mains de joueurs.

function bon_joueur()
    press = readline()
    while press != "O"
        println("Essayez de nouveau.")
        press = readline()
    end
end

function partie98()
    println("Mise en place du jeu : combien de joueurs ?")
    nb_jr = parse(Int64,readline())
    Jeu_98 = mise_en_place(nb_jr)
    while Jeu_98["compteur"][] < 98 
        for i in 1:nb_jr
            println("Joueur ", i, " joue ? Taper O si oui.")
            bon_joueur()
            println("Quelle carte voulez-vous jouer ? Entrer son emplacement (1 à 5).")
            println(Jeu_98[i])
            index = parse(Int64,readline())
            print("\e[2J") # effacer ce qui précède -> pas de triche
            jouer(Jeu_98["compteur"], Jeu_98[i], index, Jeu_98["defausse"], Jeu_98["pioche"])
            if Jeu_98["compteur"][] >= 98 break end
            
            ## Pas sûr que cette partie marche
            if Jeu_98["pioche"] == ""
                Jeu_98["pioche"] = shuffle!(Jeu_98["defausse"])
                Jeu_98["defausse"] = Paquet(Carte[])   
            end
            ##

        end
    end
    println("Fin du jeu.")
end


# Jeu fini !!! (en terminal)