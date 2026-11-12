# Fish Out of Water

A 2D action platformer built in **Godot 4.5** with **GDScript**. You play as a fish stranded on land. Fight through a polluted industrial world, managing a limited **water supply** that you drink to heal. Fountains refill it and act as checkpoints.

**[▶ Download the latest Windows build](https://github.com/kinan897/Fish-Out-of-The-Water/releases/latest)**

## Features

- **Tight platformer movement.** Double jump, dash, wall slide and wall jump, with variable jump height, coyote time, jump buffering and fast-fall.
- **Melee combat.** Sword attacks, with knockback and invincibility frames when the player is hit.
- **Healing resource.** Hold Drink to spend water: every three sips restores a heart. Fountains refill health and water and set your respawn point.
- **Speedrun timer** on the HUD.
- **Eight enemy types.** Bug, Big Bug, Drone, Big Drone, Fly, Robot, Fish and Shark, all built on a shared `EnemyBase` with Walk, Hit and Die states.
- **World interaction.** Breakable walls, spike hazards, NPC dialogue, an intro sequence and a factory self-destruct sequence.
- **Parallax backgrounds**, sound effects and music.
- **Keyboard and controller support.**

## Architecture

- **Finite state machine.** A reusable `StateMachine` / `State` system (`StateMachine/`) drives the player, every enemy and breakable walls. Each state handles its own `Enter`, `Exit`, `Update`, `PhysicsUpdate` and `HandleInput`, and transitions carry data through `StateMessage` objects.
- **Player states.** Idle, Run, Air, Dash, Attack, WallSlide, WallJump, Drink, Hurt and Death (`Player/States/`).
- **Physics-based jump tuning.** Jump gravity and velocity are calculated from the designer-facing *jump height*, *time to peak* and *time to descend* values, all exposed as `@export` variables so they can be tuned in the editor.
- **Global singleton.** `Global` (autoload) tracks health, water, the respawn point, the run timer, music and the HUD.

```
Player/          player controller + states
Enemys/          EnemyBase + one folder per enemy type
StateMachine/    generic FSM (State, StateMachine, StateMessage)
Singletons/      Global game state + UI
Scenes/          levels, intro, factory sequence
Assets/          sprites, tilesets, backgrounds, audio
```

## Controls

| Action | Keyboard | Controller |
|---|---|---|
| Move | A / D or ← / → | D-pad |
| Jump (double jump) | Space or ↑ | A |
| Dash | Shift | — |
| Attack | Enter | X |
| Drink to heal | Q | B / Y |
| Talk to NPC | W or ↑ | D-pad up |
| Restart | R | — |

## Running from source

1. Install [Godot 4.5](https://godotengine.org/download).
2. Clone the repo: `git clone https://github.com/kinan897/Fish-Out-of-The-Water.git`
3. In Godot, choose **Import**, select `project.godot`, then press **F5**.

## Credits

- The player controller design was adapted from [ChrisMGeo/GodotHollowKnightController](https://github.com/ChrisMGeo/GodotHollowKnightController).
- Music: *Minifantasy Dungeon Music* by Leohpaz.
- Sprites, tilesets and sound effects come from third-party asset packs, used under their respective licenses.
