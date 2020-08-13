import json


class Authentication:
    def __init__(self, token, status):
        self.token = str(token)
        self.status = status

    def is_authenticated(self):
        return self.token is not None and self.status == 'SUCCESS'

    def to_json(self):
        return json.dumps(self, default=lambda o: o.__dict__,
                          sort_keys=True, indent=4)
