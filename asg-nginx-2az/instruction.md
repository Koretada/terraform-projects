---

### **Étape 1 : Déploiement de la Stack Web Modulaire et Résiliente (VPC / ALB / ASG)**

#### **1. Module Réseau (VPC)**
- [x] Créer un VPC réparti sur **2 zones de disponibilité (AZ)**.
- [x] Définir les sous-réseaux : 2 subnets publics et 2 subnets privés.
- [x] Configurer une NAT Gateway. 

#### **2. Module Sécurité (Security Groups)**
- [x] Créer le Security Group de l'ALB (autoriser le trafic entrant HTTP/80 depuis Internet `0.0.0.0/0`).
- [x] Créer le Security Group des instances EC2 (autoriser le trafic HTTP **strictement restreint** à la source du SG de l'ALB).
- [ ] Utiliser des **`dynamic blocks`** dans le code Terraform pour générer proprement les règles d'ingress/egress.

#### **3. Module Compute (Launch Template & ASG)**
- [x] Rédiger le script `user-data` pour l'installation et le démarrage de Nginx.
- [x] Utiliser la fonction **`templatefile`** pour injecter dynamiquement les variables d'environnement dans le `user-data`.
- [x] Créer le Launch Template configuré sur une architecture AMD.
- [x] Configurer l'Auto Scaling Group (ASG) associé au Launch Template et réparti sur les 2 AZs.

#### **4. Load Balancing & Routage (ALB)**
- [ ] Déployer l'Application Load Balancer (ALB) sur les subnets publics.
- [ ] Configurer le Target Group (Health Checks Nginx) et l'associer à l'ASG.
- [ ] Créer le Listener HTTP pour router le trafic de l'ALB vers le Target Group.

#### **5. Validation & Tests (Definition of Done)**
- [ ] Vérifier que la page Nginx répond correctement via le nom DNS public de l'ALB.
- [ ] Valider l'étanchéité réseau (les instances ne doivent pas être joignables en direct depuis l'extérieur).
- [ ] Vérifier le temps de déploiement / destruction complet du code IaC (**cible : 3 à 4 min**).