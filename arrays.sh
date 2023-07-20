#!/bin/bash

# Función para imprimir el menú
function print_menu {
    echo "Operaciones con Arrays"
    echo "1. Crear un nuevo array unidimensional"
    echo "2. Crear una nueva matriz bidimensional"
    echo "3. Agregar elemento al array o matriz"
    echo "4. Eliminar elemento del array o matriz"
    echo "5. Buscar elemento en el array o matriz"
    echo "6. Ordenar el array o matriz"
    echo "7. Mostrar elementos del array o matriz"
    echo "8. Salir"
}

# Función para crear un nuevo array unidimensional
function create_array {
    read -p "Ingresa los elementos del array separados por espacios: " -a array
    echo "Array unidimensional creado correctamente."
}

# Función para crear una nueva matriz bidimensional
function create_matrix {
    read -p "Ingresa el número de filas de la matriz: " rows
    read -p "Ingresa el número de columnas de la matriz: " cols

    for (( i = 0; i < rows; i++ )); do
        for (( j = 0; j < cols; j++ )); do
            read -p "Ingresa el elemento para la fila $((i+1)), columna $((j+1)): " element
            matrix[$i][$j]=$element
        done
    done

    echo "Matriz bidimensional creada correctamente."
}

# Función para agregar un elemento al array o matriz
function add_element {
    read -p "Ingresa el elemento que deseas agregar: " element

    if [[ ${#matrix[@]} -eq 0 ]]; then
        array+=("$element")
        echo "Elemento agregado al array unidimensional correctamente."
    else
        read -p "Ingresa el número de fila donde deseas agregar el elemento: " row
        read -p "Ingresa el número de columna donde deseas agregar el elemento: " col

        if [[ $row -ge 1 && $row -le ${#matrix[@]} && $col -ge 1 && $col -le ${#matrix[0]} ]]; then
            matrix[$((row-1))][$((col-1))]=$element
            echo "Elemento agregado a la matriz bidimensional correctamente."
        else
            echo "Posición inválida. Inténtalo nuevamente."
        fi
    fi
}

# Función para eliminar un elemento del array o matriz
function remove_element {
    if [[ ${#matrix[@]} -eq 0 ]]; then
        read -p "Ingresa el índice del elemento que deseas eliminar del array: " index
        if [[ $index -ge 0 && $index -lt ${#array[@]} ]]; then
            unset "array[$index]"
            array=("${array[@]}")
            echo "Elemento eliminado del array unidimensional correctamente."
        else
            echo "Índice inválido. Inténtalo nuevamente."
        fi
    else
        read -p "Ingresa el número de fila del elemento que deseas eliminar: " row
        read -p "Ingresa el número de columna del elemento que deseas eliminar: " col

        if [[ $row -ge 1 && $row -le ${#matrix[@]} && $col -ge 1 && $col -le ${#matrix[0]} ]]; then
            unset "matrix[$((row-1))][$((col-1))]"
            echo "Elemento eliminado de la matriz bidimensional correctamente."
        else
            echo "Posición inválida. Inténtalo nuevamente."
        fi
    fi
}

# Función para buscar un elemento en el array o matriz
function search_element {
    read -p "Ingresa el elemento que deseas buscar: " search_item

    if [[ ${#matrix[@]} -eq 0 ]]; then
        if [[ " ${array[*]} " == *" $search_item "* ]]; then
            echo "Elemento encontrado en el array unidimensional."
        else
            echo "Elemento no encontrado en el array unidimensional."
        fi
    else
        found=0
        for (( i = 0; i < ${#matrix[@]}; i++ )); do
            for (( j = 0; j < ${#matrix[0]}; j++ )); do
                if [[ "${matrix[$i][$j]}" == "$search_item" ]]; then
                    found=1
                    break 2
                fi
            done
        done

        if [[ $found -eq 1 ]]; then
            echo "Elemento encontrado en la matriz bidimensional."
        else
            echo "Elemento no encontrado en la matriz bidimensional."
        fi
    fi
}

# Función para ordenar el array o matriz
function sort_array {
    if [[ ${#matrix[@]} -eq 0 ]]; then
        IFS=$'\n' sorted=($(sort <<<"${array[*]}"))
        unset IFS
        array=("${sorted[@]}")
        echo "Array unidimensional ordenado correctamente."
    else
        echo "Ordenar una matriz bidimensional no es compatible en este script."
    fi
}

# Función para mostrar los elementos del array o matriz
function show_array {
    echo "Elementos del array o matriz:"

    if [[ ${#matrix[@]} -eq 0 ]]; then
        for element in "${array[@]}"; do
            echo "$element"
        done
    else
        for (( i = 0; i < ${#matrix[@]}; i++ )); do
            for (( j = 0; j < ${#matrix[0]}; j++ )); do
                echo -n "${matrix[$i][$j]} "
            done
            echo
        done
    fi
}

# Main del script
array=()
matrix=()

while true; do
    print_menu
    read -p "Selecciona una opción (1-8): " choice

    case $choice in
        1) create_array ;;
        2) create_matrix ;;
        3) add_element ;;
        4) remove_element ;;
        5) search_element ;;
        6) sort_array ;;
        7) show_array ;;
        8) echo "Saliendo del script."; exit ;;
        *) echo "Opción inválida. Inténtalo nuevamente." ;;
    esac

    echo
done
