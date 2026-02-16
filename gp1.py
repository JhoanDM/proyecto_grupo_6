import tkinter as tk
from tkinter import messagebox

def cambiar_tamaño():
    try:
        ancho = int(entry_ancho.get())
        alto = int(entry_alto.get())
        ventana.geometry(f"{ancho}x{alto}")
    except ValueError:
        messagebox.showerror("Error", "Ingrese números válidos")

def salir():
    ventana.quit()

ventana = tk.Tk()
ventana.title("Control de Ventana")
ventana.geometry("400x200")

frame = tk.Frame(ventana)
frame.pack(pady=10)

tk.Label(frame, text="Ancho:").grid(row=0, column=0, padx=5)
entry_ancho = tk.Entry(frame, width=10)
entry_ancho.grid(row=0, column=1, padx=5)

tk.Label(frame, text="Alto:").grid(row=1, column=0, padx=5)
entry_alto = tk.Entry(frame, width=10)
entry_alto.grid(row=1, column=1, padx=5)

menubar = tk.Menu(ventana)
ventana.config(menu=menubar)

menu_opciones = tk.Menu(menubar, tearoff=0)
menubar.add_cascade(label="Opciones", menu=menu_opciones)
menu_opciones.add_command(label="Cambiar tamaño", command=cambiar_tamaño)
menu_opciones.add_separator()
menu_opciones.add_command(label="Salir", command=salir)

ventana.mainloop()