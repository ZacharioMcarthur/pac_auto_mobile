import requests
import sys

def verify_backend():
    # Remplace par l'IP configurée dans ton api_config.dart
    base_url = "http://10.35.101.88:8000/api" 
    
    print(f"--- Vérification du Backend PAC ---")
    try:
        # On tente de joindre une route simple (ex: login ou une route de santé)
        response = requests.get(base_url, timeout=5)
        
        # Laravel renvoie souvent 405 sur un GET /api, c'est bon signe (le serveur répond)
        if response.status_code < 500:
            print(f"✅ Serveur Laravel accessible ({response.status_code})")
            return True
    except requests.exceptions.ConnectionError:
        print("❌ ERREUR : Le backend est injoignable.")
        print("👉 Vérifie que XAMPP est lancé et que 'php artisan serve' tourne.")
        return False

if __name__ == "__main__":
    if not verify_backend():
        sys.exit(1) # Arrête le processus en cas d'échec