from flask import Flask, request, render_template, redirect, url_for
import zeep

app = Flask(__name__)
wsdl = 'http://localhost:8080/PersonService?wsdl'  # URL to your SOAP service WSDL
client = zeep.Client(wsdl=wsdl)

@app.route('/', methods=['GET', 'POST'])
def index():
    # Search functionality
    search_nni = request.args.get('search_nni')
    all_persons = []

    # Handling POST request for adding a new person
    if request.method == 'POST':
        nni = request.form.get('nni')
        nom = request.form.get('nom')
        client.service.addPerson({'nni': nni, 'nom': nom})

    # Search for a person by ID if a search query is provided
    if search_nni:
        person = client.service.getPerson(search_nni)
        if person:
            all_persons.append(person)
    else:
        # Fetch all persons for listing if no search query is provided
        all_persons = client.service.getAllPersons()

    return render_template('index.html', persons=all_persons)


@app.route('/update_person/<int:nni>', methods=['POST'])
def update_person(nni):
    nom = request.form.get('new_nom')
    client.service.updatePerson({'nni': nni, 'nom': nom})
    return redirect(url_for('index'))

@app.route('/delete_person/<int:nni>', methods=['POST'])
def delete_person(nni):
    person = client.service.getPerson(nni)
    client.service.deletePerson(person)
    return redirect(url_for('index'))



if __name__ == '__main__':
    app.run(debug=True)
