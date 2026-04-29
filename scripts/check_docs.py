import os
import sys

def check_readme():
    if not os.path.exists("README.md"):
        print("Erreur : Le fichier README.md est manquant !")
        sys.exit(1)
    
    with open("README.md", "r", encoding="utf-8") as f:
        content = f.read()
        if "TODO" in content.upper():
            print("Attention : Il reste des tâches 'TODO' dans le README.")
            # On ne bloque pas forcément le build, mais on prévient
    
    print("Documentation vérifiée avec succès.")

if __name__ == "__main__":
    check_readme()
    