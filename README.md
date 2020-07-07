# second_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Algunas lecciones aprendidas : 
- Algunos widgets como los textfield dentro de NewTransaction se reevaluan y pierden el contenido que tienen al escribirse. La soluciòn para ello
 es convertirlo en un widget con estado.
- Flexible( fit: FlexFit.tight... evita que una fila o columna crezca màs de lo que le corresponde (flex : 1 por defecto)
- FittedBox ... fuerza al hijo al espacio disponible, si el hijo es un texto entonces reduce su tamanio de fuente para que 
pueda calzar.
- Si se requiere a un *Container* solo para colocar un padding entonces mejor reemplazarlo por un widget *Padding*
- Para màs info acerca de los propiedades flex en flutter, regresar al capìtulo 104 - Desarrollo flutter
