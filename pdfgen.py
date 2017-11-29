from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
canvas = canvas.Canvas("information.pdf", pagesize=letter)
from reportlab.lib.units import inch
import time

canvas.setLineWidth(.3)
canvas.setFont('Helvetica', 16)
canvas.drawString(300, 750, "Sydney")

canvas.line(300,747,355,747)

canvas.setFont('Helvetica', 12)
canvas.drawString(450, 735, time.asctime(time.localtime()))

canvas.drawString(30, 700, "System Details :")


crosshairs = [(20, 0, 20, 10), (20, 30, 20, 40), (0, 20, 10, 20), (3, 20, 40, 20)]
canvas.lines(crosshairs)

canvas.save()