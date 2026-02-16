import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
from tkinter.simpledialog import askinteger

# ------------------ FUNCIONES ------------------

def registrar_usuario():
    nombre = entry_nombre.get()
    edad = entry_edad.get()
    ciudad = combo_ciudad.get()

    if nombre == "" or edad == "":
        messagebox.showerror("Error", "Debe ingresar nombre y edad")
        return

    label_resultado_usuario.config(
        text=f"Usuario: {nombre} – Edad: {edad} años – Ciudad: {ciudad}"
    )


def confirmar_servicio():
    servicio = servicio_var.get()
    label_servicio.config(text=f"Servicio seleccionado: {servicio}")


def activar_boton():
    if check_var.get() == 1:
        btn_continuar.config(state="normal")
    else:
        btn_continuar.config(state="disabled")


def agregar_servicios():
    seleccionados = listbox_servicios.curselection()
    lista = [listbox_servicios.get(i) for i in seleccionados]

    if lista:
        label_lista.config(text="Servicios adicionales: " + ", ".join(lista))
    else:
        label_lista.config(text="No seleccionó servicios adicionales")


def continuar():
    prioridad = spin_prioridad.get()

    if prioridad == "0":
        messagebox.showerror("Error", "Debe seleccionar una prioridad mayor a 0")
    else:
        messagebox.showinfo("Éxito", "Formulario enviado correctamente")


def limpiar_formulario():
    entry_nombre.delete(0, tk.END)
    entry_edad.delete(0, tk.END)
    combo_ciudad.set("")
    servicio_var.set("")
    check_var.set(0)
    btn_continuar.config(state="disabled")
    spin_prioridad.delete(0, tk.END)
    spin_prioridad.insert(0, "0")
    listbox_servicios.selection_clear(0, tk.END)
    label_resultado_usuario.config(text="")
    label_servicio.config(text="")
    label_lista.config(text="")


def cambiar_tamano():
    ancho = askinteger("Ancho", "Ingrese nuevo ancho:")
    alto = askinteger("Alto", "Ingrese nuevo alto:")

    if ancho and alto:
        ventana.geometry(f"{ancho}x{alto}")


# ------------------ VENTANA PRINCIPAL ------------------

ventana = tk.Tk()
ventana.title("Centro de Servicios Interactivos")
ventana.geometry("800x700")

# ------------------ MENÚ ------------------

menu_bar = tk.Menu(ventana)

menu_archivo = tk.Menu(menu_bar, tearoff=0)
menu_archivo.add_command(label="Limpiar formulario", command=limpiar_formulario)
menu_archivo.add_command(label="Salir", command=ventana.quit)

menu_ventana = tk.Menu(menu_bar, tearoff=0)
menu_ventana.add_command(label="Cambiar tamaño", command=cambiar_tamano)

menu_bar.add_cascade(label="Archivo", menu=menu_archivo)
menu_bar.add_cascade(label="Ventana", menu=menu_ventana)

ventana.config(menu=menu_bar)

# ------------------ SECCIÓN DATOS USUARIO ------------------

frame_usuario = ttk.LabelFrame(ventana, text="Datos del Usuario")
frame_usuario.grid(row=0, column=0, padx=10, pady=10, sticky="w")

tk.Label(frame_usuario, text="Nombre:").grid(row=0, column=0)
entry_nombre = tk.Entry(frame_usuario)
entry_nombre.grid(row=0, column=1)

tk.Label(frame_usuario, text="Edad:").grid(row=1, column=0)
entry_edad = tk.Entry(frame_usuario)
entry_edad.grid(row=1, column=1)

tk.Label(frame_usuario, text="Ciudad:").grid(row=2, column=0)
combo_ciudad = ttk.Combobox(frame_usuario, values=["Bogotá", "Medellín", "Cali", "Barranquilla"])
combo_ciudad.grid(row=2, column=1)

ttk.Button(frame_usuario, text="Registrar", command=registrar_usuario).grid(row=3, column=0, columnspan=2, pady=5)

label_resultado_usuario = tk.Label(frame_usuario, text="")
label_resultado_usuario.grid(row=4, column=0, columnspan=2)

# ------------------ SECCIÓN RADIOBUTTON ------------------

frame_servicio = ttk.LabelFrame(ventana, text="Selección de Servicio")
frame_servicio.grid(row=1, column=0, padx=10, pady=10, sticky="w")

servicio_var = tk.StringVar()

tk.Radiobutton(frame_servicio, text="Consulta", variable=servicio_var, value="Consulta").grid(row=0, column=0)
tk.Radiobutton(frame_servicio, text="Reclamo", variable=servicio_var, value="Reclamo").grid(row=0, column=1)
tk.Radiobutton(frame_servicio, text="Petición", variable=servicio_var, value="Petición").grid(row=0, column=2)

ttk.Button(frame_servicio, text="Confirmar servicio", command=confirmar_servicio).grid(row=1, column=0, columnspan=3)

label_servicio = tk.Label(frame_servicio, text="")
label_servicio.grid(row=2, column=0, columnspan=3)

# ------------------ CHECKBUTTON ------------------

check_var = tk.IntVar()

frame_terminos = ttk.LabelFrame(ventana, text="Términos y Condiciones")
frame_terminos.grid(row=2, column=0, padx=10, pady=10, sticky="w")

tk.Checkbutton(frame_terminos, text="Acepto términos y condiciones",
               variable=check_var, command=activar_boton).grid(row=0, column=0)

btn_continuar = ttk.Button(frame_terminos, text="Continuar", state="disabled", command=continuar)
btn_continuar.grid(row=1, column=0, pady=5)

# ------------------ LISTBOX ------------------

frame_lista = ttk.LabelFrame(ventana, text="Servicios Adicionales")
frame_lista.grid(row=3, column=0, padx=10, pady=10, sticky="w")

listbox_servicios = tk.Listbox(frame_lista, selectmode=tk.MULTIPLE)
listbox_servicios.grid(row=0, column=0)

servicios = ["Copias", "Certificados", "Asesoría", "Turno preferencial"]

for s in servicios:
    listbox_servicios.insert(tk.END, s)

ttk.Button(frame_lista, text="Agregar servicios", command=agregar_servicios).grid(row=1, column=0)

label_lista = tk.Label(frame_lista, text="")
label_lista.grid(row=2, column=0)

# ------------------ SPINBOX ------------------

frame_prioridad = ttk.LabelFrame(ventana, text="Nivel de Prioridad")
frame_prioridad.grid(row=4, column=0, padx=10, pady=10, sticky="w")

spin_prioridad = tk.Spinbox(frame_prioridad, from_=0, to=5)
spin_prioridad.grid(row=0, column=0)
spin_prioridad.delete(0, tk.END)
spin_prioridad.insert(0, "0")

# ------------------ CANVAS ------------------

frame_canvas = ttk.LabelFrame(ventana, text="Logo del Sistema")
frame_canvas.grid(row=5, column=0, padx=10, pady=10)

canvas = tk.Canvas(frame_canvas, width=200, height=120, bg="white")
canvas.grid(row=0, column=0)

canvas.create_rectangle(20, 20, 180, 80)
canvas.create_oval(70, 40, 130, 100)
canvas.create_line(0, 0, 200, 120)

# ------------------

ventana.mainloop()
import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
from tkinter.simpledialog import askinteger

# ------------------ FUNCIONES ------------------

def registrar_usuario():
    nombre = entry_nombre.get()
    edad = entry_edad.get()
    ciudad = combo_ciudad.get()

    if nombre == "" or edad == "":
        messagebox.showerror("Error", "Debe ingresar nombre y edad")
        return

    label_resultado_usuario.config(
        text=f"Usuario: {nombre} – Edad: {edad} años – Ciudad: {ciudad}"
    )


def confirmar_servicio():
    servicio = servicio_var.get()
    label_servicio.config(text=f"Servicio seleccionado: {servicio}")


def activar_boton():
    if check_var.get() == 1:
        btn_continuar.config(state="normal")
    else:
        btn_continuar.config(state="disabled")


def agregar_servicios():
    seleccionados = listbox_servicios.curselection()
    lista = [listbox_servicios.get(i) for i in seleccionados]

    if lista:
        label_lista.config(text="Servicios adicionales: " + ", ".join(lista))
    else:
        label_lista.config(text="No seleccionó servicios adicionales")


def continuar():
    prioridad = spin_prioridad.get()

    if prioridad == "0":
        messagebox.showerror("Error", "Debe seleccionar una prioridad mayor a 0")
    else:
        messagebox.showinfo("Éxito", "Formulario enviado correctamente")


def limpiar_formulario():
    entry_nombre.delete(0, tk.END)
    entry_edad.delete(0, tk.END)
    combo_ciudad.set("")
    servicio_var.set("")
    check_var.set(0)
    btn_continuar.config(state="disabled")
    spin_prioridad.delete(0, tk.END)
    spin_prioridad.insert(0, "0")
    listbox_servicios.selection_clear(0, tk.END)
    label_resultado_usuario.config(text="")
    label_servicio.config(text="")
    label_lista.config(text="")


def cambiar_tamano():
    ancho = askinteger("Ancho", "Ingrese nuevo ancho:")
    alto = askinteger("Alto", "Ingrese nuevo alto:")

    if ancho and alto:
        ventana.geometry(f"{ancho}x{alto}")


# ------------------ VENTANA PRINCIPAL ------------------

ventana = tk.Tk()
ventana.title("Centro de Servicios Interactivos")
ventana.geometry("800x700")

# ------------------ MENÚ ------------------

menu_bar = tk.Menu(ventana)

menu_archivo = tk.Menu(menu_bar, tearoff=0)
menu_archivo.add_command(label="Limpiar formulario", command=limpiar_formulario)
menu_archivo.add_command(label="Salir", command=ventana.quit)

menu_ventana = tk.Menu(menu_bar, tearoff=0)
menu_ventana.add_command(label="Cambiar tamaño", command=cambiar_tamano)

menu_bar.add_cascade(label="Archivo", menu=menu_archivo)
menu_bar.add_cascade(label="Ventana", menu=menu_ventana)

ventana.config(menu=menu_bar)

# ------------------ SECCIÓN DATOS USUARIO ------------------

frame_usuario = ttk.LabelFrame(ventana, text="Datos del Usuario")
frame_usuario.grid(row=0, column=0, padx=10, pady=10, sticky="w")

tk.Label(frame_usuario, text="Nombre:").grid(row=0, column=0)
entry_nombre = tk.Entry(frame_usuario)
entry_nombre.grid(row=0, column=1)

tk.Label(frame_usuario, text="Edad:").grid(row=1, column=0)
entry_edad = tk.Entry(frame_usuario)
entry_edad.grid(row=1, column=1)

tk.Label(frame_usuario, text="Ciudad:").grid(row=2, column=0)
combo_ciudad = ttk.Combobox(frame_usuario, values=["bucaramanga", "piedecuesta", "floridablanca", ])
combo_ciudad.grid(row=2, column=1)

ttk.Button(frame_usuario, text="Registrar", command=registrar_usuario).grid(row=3, column=0, columnspan=2, pady=5)

label_resultado_usuario = tk.Label(frame_usuario, text="")
label_resultado_usuario.grid(row=4, column=0, columnspan=2)

# ------------------ SECCIÓN RADIOBUTTON ------------------

frame_servicio = ttk.LabelFrame(ventana, text="Selección de Servicio")
frame_servicio.grid(row=1, column=1, padx=10, pady=10, sticky="w")

servicio_var = tk.StringVar()

tk.Radiobutton(frame_servicio, text="Consulta", variable=servicio_var, value="Consulta").grid(row=0, column=0)
tk.Radiobutton(frame_servicio, text="Reclamo", variable=servicio_var, value="Reclamo").grid(row=0, column=1)
tk.Radiobutton(frame_servicio, text="Petición", variable=servicio_var, value="Petición").grid(row=0, column=2)

ttk.Button(frame_servicio, text="Confirmar servicio", command=confirmar_servicio).grid(row=1, column=0, columnspan=3)

label_servicio = tk.Label(frame_servicio, text="")
label_servicio.grid(row=2, column=0, columnspan=3)

# ------------------ CHECKBUTTON ------------------

check_var = tk.IntVar()

frame_terminos = ttk.LabelFrame(ventana, text="Términos y Condiciones")
frame_terminos.grid(row=0, column=2, padx=10, pady=10, sticky="w")

tk.Checkbutton(frame_terminos, text="Acepto términos y condiciones",
               variable=check_var, command=activar_boton).grid(row=0, column=0)

btn_continuar = ttk.Button(frame_terminos, text="Continuar", state="disabled", command=continuar)
btn_continuar.grid(row=1, column=0, pady=5)

# ------------------ LISTBOX ------------------

frame_lista = ttk.LabelFrame(ventana, text="Servicios Adicionales")
frame_lista.grid(row=3, column=2, padx=10, pady=10, sticky="w")

listbox_servicios = tk.Listbox(frame_lista, selectmode=tk.MULTIPLE)
listbox_servicios.grid(row=0, column=0)

servicios = ["Copias", "Certificados", "Asesoría", "Turno preferencial"]

for s in servicios:
    listbox_servicios.insert(tk.END, s)

ttk.Button(frame_lista, text="Agregar servicios", command=agregar_servicios).grid(row=1, column=0)

label_lista = tk.Label(frame_lista, text="")
label_lista.grid(row=2, column=0)

# ------------------ SPINBOX ------------------

frame_prioridad = ttk.LabelFrame(ventana, text="Nivel de Prioridad")
frame_prioridad.grid(row=0, column=1, padx=10, pady=10, sticky="w")

spin_prioridad = tk.Spinbox(frame_prioridad, from_=0, to=5)
spin_prioridad.grid(row=0, column=0)
spin_prioridad.delete(0, tk.END)
spin_prioridad.insert(0, "0")

# ------------------ CANVAS ------------------

frame_canvas = ttk.LabelFrame(ventana, text="Logo del Sistema")
frame_canvas.grid(row=1, column=0, padx=10, pady=10)

canvas = tk.Canvas(frame_canvas, width=200, height=120, bg="black")
canvas.grid(row=0, column=0)

canvas.create_rectangle(20, 20, 180, 80, fill="blue")
canvas.create_oval(70, 40, 130, 100, fill="green")
canvas.create_line(0, 0, 200, 120, fill="red")

# ------------------

ventana.mainloop()
