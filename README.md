<<<<<<< HEAD
# CrudProjetoFinal

A new Flutter project created with FlutLab - https://flutlab.io

## Getting Started

A few resources to get you started if this is your first Flutter project:

- https://flutter.dev/docs/get-started/codelab
- https://flutter.dev/docs/cookbook

For help getting started with Flutter, view our
https://flutter.dev/docs, which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Getting Started: FlutLab - Flutter Online IDE

- How to use FlutLab? Please, view our https://flutlab.io/docs
- Join the discussion and conversation on https://flutlab.io/residents
=======
# Parking Spot Management Application

## Overview
This application is a simple Flutter-based mobile app for managing parking spots via a REST API. It allows users to perform Create, Read, Update, and Delete (CRUD) operations on parking spots, interacting with a remote server.

## Features
- List all parking spots
- Add a new parking spot
- Edit an existing parking spot
- Delete a parking spot
- View parking spot details
- Sort and paginate parking spot listings

## API Documentation
The application consumes the following REST API endpoints:

- **Get Parking Spot List:**  
  `GET https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/list`

- **Get Ordered Parking Spot List:**  
  `GET https://controle-vaga.herokuapp.com/parking-spot/order?page=0&size=10&sort=registrationDate,ASC`

- **Get Parking Spot by ID:**  
  `GET https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/{id}`

- **Update Parking Spot:**  
  `PUT https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/{id}`

- **Create Parking Spot:**  
  `POST https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/save`

- **Delete Parking Spot:**  
  `DELETE https://parking-spot-238adfbb7467.herokuapp.com/delete/{id}`

- **Edit Parking Spot:**  
  `POST https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/edit`

For more details, refer to the [API documentation](https://documenter.getpostman.com/view/4601883/2s8YY9xTHv).

## Installation
Clone this repository and import into **Android Studio** or **VS Code**:

```bash
git clone https://github.com/SeixasCco/PegaMoedaFlutter.git
>>>>>>> f63410c08d24e05e5daf137796fe6b3bac1ce987
