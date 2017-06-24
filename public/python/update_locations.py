import firebase
from pprint import pprint

URL = 'airpressure-dffa0'
u1 = URL + '/locations'
S = firebase.subscriber(u1, pprint)

S.start()