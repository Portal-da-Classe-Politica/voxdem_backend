-- Questions for Deputados survey with explicit IDs
-- IDs start at 2000 to avoid conflicts with other surveys

INSERT INTO questions (id, code, text, answer_group_id, survey_id, question_order, is_active) VALUES
  (2000, 'P1', 'Satisfação com a democracia', 100, 2, 1, 't'),
  (2001, 'P3_1', 'Que as eleições nacionais sejam livres e justas.', 101, 2, 2, 't'),
  (2002, 'P3_2', 'Que os eleitores discutam política com pessoas que conhecem antes de decidir como votar.', 101, 2, 3, 't'),
  (2003, 'P3_3', 'Que os partidos de oposição sejam livres para criticar o governo.', 101, 2, 4, 't'),
  (2004, 'P3_4', 'Que a mídia seja livre para criticar o governo.', 101, 2, 5, 't'),
  (2005, 'P3_5', 'Que os direitos de grupos minoritários sejam protegidos.', 101, 2, 6, 't'),
  (2006, 'P3_6', 'Que os cidadãos tenham a palavra final sobre as questões políticas mais importantes, votando diretamente em plebiscitos e referendos.', 101, 2, 7, 't'),
  (2007, 'P3_7', 'Que os tribunais tratem todos da mesma forma.', 101, 2, 8, 't'),
  (2008, 'P3_8', 'Que os tribunais sejam capazes de impedir o governo de agir além de sua autoridade, praticando ilegalidades.', 101, 2, 9, 't'),
  (2009, 'P3_9', 'Que os partidos governistas sejam punidos nas eleições quando fizeram um trabalho ruim.', 101, 2, 10, 't'),
  (2010, 'P3_10', 'Que o governo proteja todos os cidadãos contra a pobreza.', 101, 2, 11, 't'),
  (2011, 'P3_11', 'Que o governo reduza as diferenças de renda e riqueza.', 101, 2, 12, 't'),
  (2012, 'P4', 'Autoposicionamento Ideológico', 109, 2, 13, 't'),
  (2013, 'P5_1', 'O Estado brasileiro, em vez do setor privado, deveria ser dono das empresas e indústrias mais importantes do país.', 102, 2, 14, 't'),
  (2014, 'P5_2', 'A decisão sobre fazer ou não um aborto deve ser tomado exclusivamente pela mulher.', 102, 2, 15, 't'),
  (2015, 'P5_3', 'Redução da maioridade penal.', 102, 2, 16, 't'),
  (2016, 'P5_4', 'Desenvolvimento econômico e criação de empregos deveriam ser prioritários, mesmo que o meio ambiente sofra algum dano.', 102, 2, 17, 't'),
  (2017, 'P5_5', 'Os humanos foram feitos para governar a natureza.', 102, 2, 18, 't'),
  (2018, 'P5_6', 'Os brancos no Brasil têm certas vantagens por causa da cor da pele.', 102, 2, 19, 't'),
  (2019, 'P5_7', 'Devemos respeitar os resultados das eleições, não importa qual candidato vença.', 102, 2, 20, 't'),
  (2020, 'P5_8', 'O STF brasileiro deve ser capaz de anular as decisões do presidente e as políticas que forem consideradas ilegais.', 102, 2, 21, 't'),
  (2021, 'P5_9', 'O presidente deve poder ignorar as decisões judiciais consideradas politicamente tendenciosas.', 102, 2, 22, 't'),
  (2022, 'P5_10', 'Que a minoria aceite a vontade da maioria em todas as circunstâncias.', 102, 2, 23, 't'),
  (2023, 'P6_1', 'Em primeiro lugar?', 143, 2, 24, 't'),
  (2024, 'P6_2', 'Em segundo lugar?', 143, 2, 25, 't');
