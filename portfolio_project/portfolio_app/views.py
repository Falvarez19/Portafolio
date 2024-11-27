from django.shortcuts import render

def home(request):
    return render(request, 'portfolio_app/home.html')

def projects(request):
    return render(request, 'portfolio_app/projects.html')

def about(request):
    return render(request, 'portfolio_app/about.html')

def contact(request):
    return render(request, 'portfolio_app/contact.html')
