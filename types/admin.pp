# A Taiga::Admin is composed of a full name and an e-mail address
type Taiga::Admin = Tuple[
  String[1],
  Pattern[/.@./],
]
