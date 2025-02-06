# lotto_generator.py

import random

class LottoGenerator:
    def __init__(self, num_numbers=6, num_range=45):
        self.num_numbers = num_numbers
        self.num_range = num_range

    def generate_numbers(self):
        return sorted(random.sample(range(1, self.num_range + 1), self.num_numbers))