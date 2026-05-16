def detect_category(location):

    location = location.lower()

    spiritual = ["tirupati", "varanasi", "kedarnath"]
    beaches = ["goa", "vizag", "pondicherry"]
    mountains = ["ooty", "manali", "shimla"]
    historical = ["hampi", "mysore", "delhi"]

    if location in spiritual:
        return "Spiritual"

    elif location in beaches:
        return "Beaches"

    elif location in mountains:
        return "Mountains"

    elif location in historical:
        return "Historical"

    return "General"