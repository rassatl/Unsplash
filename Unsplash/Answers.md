#### le numéro de l’étape, son nom et le numéro de l’exercice.

# 2 - Grid

## Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.
Le LazyVGrid permet de faire une grille verticale et on l'utiliser pour afficher des composants asyncrone.

## Expliquez les différents types de colonnes et pourquoi on utilise flexible ici.
Différents types de colonnes : 
    - Fixed : taille fixe qui ne peut pas s'adapter et s'il n'y à pas assez d'espace sur l'écran, l'image peut dépasser
    - Flexible : les colonnes vont essayé de contenir les images mais s'il n'y à pas assez d'espace, cela va créer une nouvelle colonne
    - Adaptive : ne prend pas en compte la taille/le nombre de colonnes qu'on lui à donné et va seulement essayé de remplir l'espace présent avec un nombre de colonne qu'il créé
    
## Votre grille ne doit pas être très jolie, expliquez pourquoi les images prennent toute la largeur de l’écran.
C'est en rajoutant un deuxième "GridItem(.flexible())" dans mon tableau que je rajoute une colonne et que cela rend ce qui est demandé.

## Expliquer ce que fait ce modifier ligne par ligne
// création d'une extention pour les composants images
extension Image {
    //création d'une fonction qui retourne un composant View
    func centerCropped() -> some View {
        //utilise une @frozen structure GeometryReader qui permet de nous dire qu'elle taille les images vont avoir pour que l'on puisse avoir 2 colonnes sans déformé les images
        GeometryReader { geo in
            // l'image actuelle
            self
            // Définit le mode par lequel SwiftUI redimensionne une image pour qu'elle s'adapte à son espace.
            .resizable()
            // Met à l'échelle cette vue pour remplir son parent.
            .scaledToFill()
            // Place cette vue à l'intérieur d'une frame invisible de la taille spécifiée.
            .frame(width: geo.size.width, height: geo.size.height)
            // Attache cette vue à son cadre rectangulaire de délimitation
            .clipped()
        }
    }
}

# 4 - Appel-Reseau
# Exercice 3
## Expliquez 3 façons différences de faire un appel asynchrone en Swift
 - async/await : Permettant au programme de continuer l'exécution sans bloquer le thread.
 - Combine : "Combine" est un framework introduit par Apple pour la programmation réactive en Swift. Il permet une approche déclarative pour gérer les flux de données asynchrones
 - completionHandler / GCD : Permet d'exécuter des blocs de code sur des files d'attente spécifiques, généralement sur des files d'attente de fond, et utiliser des completionHandler pour traiter les résultats.
