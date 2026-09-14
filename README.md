# Phylactery (Reverse Tower Defense)
## Game Design Document

**Working Title:** Phylactery  
**Genre:** Reverse tower defense  
**Engine:** Godot  
**Language:** GDScript

---

## 1. Overview

The Player takes on the role of a Lich conquering a Kingdom. The Player does not defend against waves. The Player commands an undead army on the offensive and lays siege to the Kingdom’s fortified positions.

As the Kingdom’s defenders fall, the Player harvests their Souls. The Player spends Souls to raise minions — and, as the campaign goes on, increasingly powerful minions that can match the Kingdom’s growing defenses.

The campaign ends when the Player confronts the King. The King’s forces stand no chance against the Lich’s dominion over life and death.

---

## 2. Technical Approach

- **Engine:** Godot
- **Language:** GDScript, chosen for rapid prototyping. The priority is iterating on core mechanics and feel rather than locking architecture early.

---

## 3. Core Gameplay Loop — The Siege

The primary loop is the **Siege**: one enemy base. The Player’s objective is to destroy that base’s **Command Tower** while spending the fewest Souls possible.

### 3.1 Resource Flow

- The Player spends **Souls** to raise minions.
- Destroying enemy structures grants Souls, which the Player can reinvest into the army mid-siege.

### 3.2 Minions

- At MVP, the Player’s only minion is the **Skeleton Warrior**: a weak, low-cost unit that charges forward automatically and attacks any obstacle or enemy in its path.
- After MVP, additional types (Skeleton Archers, Zombie Masses) diversify strategy and counter specific defenses.

### 3.3 Defenses

The Kingdom’s defenses stand between the Player’s army and the Command Tower.

| Defense | Behavior |
|---|---|
| **Wall** | Blocks minion movement until destroyed. Melee minions cannot attack past a wall. |
| **Archer Tower** | Deals ranged damage to advancing minions until destroyed. |

### 3.4 Win / Loss

- **Victory:** The Player destroys the Command Tower.
- **Defeat:** The Player runs out of both Souls and active minions.

---

## 4. MVP Feature Roadmap

Features are listed with an estimated relative effort score (higher = more implementation time).

- [x] Minion spawning + minion pathing to defense
- [x] Minions attack and destroy defenses
- [ ] Archer tower defense attacking/killing minions, wall barrier
- [ ] Souls resource, minions cost Souls, destroying defenses gives Souls
- [ ] Win condition: destroy Command Tower. Lose condition: run out of Souls and active minions

---

## 5. Post-MVP

- Additional minion types (Skeleton Archer, Zombie Mass) for ranged and swarm play.
- Additional defensive structures.
- Progression: The Player plays sieges until they run out of Souls or kill the King. Between sieges the Player spends Souls to research — unlock new minions, learn spells, upgrade minions and spells, learn abilities.
- Roguelite: each run feels different because the Player chooses different abilities.
