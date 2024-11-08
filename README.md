![GitHub all releases](https://img.shields.io/github/downloads/NeonOceAu/neon_cityhall/total?color=blue&style=flat-square)

# City Hall Script for QBCore

A City Hall script for FiveM servers using the QBCore framework. This script provides a customizable City Hall ped with interaction options, job assignments, license management, and a viewable list of city laws.

## Features

- **City Hall Ped**: Configurable ped location, model, and interaction options with **ox_target**, **qb-target**, or **text UI**.
- **Blip Display**: Optional blip for City Hall with customizable icon and settings.
- **City Hall Services Menu**:
  - **Available Jobs**: Configurable job list, allowing players to apply for jobs.
  - **License Management**: Purchase or view player licenses.
  - **City Laws**: Organized laws by category, viewable in nested menus.
- **Notifications**: All messages are stored in `strings.lua` for easy customization.
- **Server-Side Security**: Protects events from unauthorized access.

## Installation

1. **Download and extract** the script to your `resources` folder.
2. **Add to server.cfg**:
   ```plaintext
   ensure neon_cityhall
   ```

3. **Dependencies**:
   - **ox_lib** (for UI and interaction features)
   - **qb-target** or **ox_target** (depending on your interaction preference)

4. **Configure the Script**:
   Open `config.lua` to adjust the following settings:
   - **Ped Location** and **Model**
   - **Blip Settings**
   - **Jobs, Licenses, and City Laws**
   - **Interaction Method**: Choose between `ox_target`, `qb-target`, or `text UI`.

## Configuration

### `config.lua`

- **Ped Settings**: Configure the ped’s model and spawn location.
- **Blip Settings**: Customize the blip for the City Hall (optional).
- **Menu Options**:
  - **Jobs**: Add jobs with names, icons, and descriptions.
  - **Licenses**: Define licenses available for purchase.
  - **City Laws**: Define laws by categories, with titles and descriptions.

### `strings.lua`

Customize all notification messages here for easy localization or adjustment.

## Usage

1. Approach the City Hall ped to open the interaction menu.
2. Choose from **Available Jobs**, **License Management**, or **City Laws**.
3. Follow on-screen prompts to purchase licenses, view owned licenses, or apply for a job.
