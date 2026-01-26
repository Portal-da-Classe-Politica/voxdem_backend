
INSERT INTO activity_sectors (id, code, description) VALUES
  (1, 1, 'Agricultura, pecuÃ¡ria, silvicultura e pesca'),
  (2, 2, 'IndÃºstria'),
  (3, 3, 'ConstruÃ§Ã£o'),
  (4, 4, 'ComÃ©rcio e reparaÃ§Ã£o'),
  (5, 5, 'Transporte, armazenagem e comunicaÃ§Ã£o'),
  (6, 6, 'Alojamento e alimentaÃ§Ã£o'),
  (7, 7, 'IntermediaÃ§Ã£o financeira'),
  (8, 8, 'Atividades imobiliÃ¡rias e serviÃ§os'),
  (9, 9, 'AdministraÃ§Ã£o pÃºblica'),
  (10, 10, 'EducaÃ§Ã£o'),
  (11, 11, 'SaÃºde e serviÃ§os sociais'),
  (12, 12, 'Outros serviÃ§os coletivos, sociais e pessoais'),
  (13, 13, 'ServiÃ§os domÃ©sticos'),
  (14, 14, 'Organismos internacionais'),
  (15, 88888, 'NÃ£o sabe'),
  (16, 98888, 'NÃ£o respondeu');


INSERT INTO activity_sectors_extended (id, code, description) VALUES
  (1, 1, 'Agricultura'),
  (2, 2, 'IndÃºst. TransformaÃ§Ã£o'),
  (3, 3, 'ConstruÃ§Ã£o - Outras'),
  (4, 4, 'ComÃ©rcio'),
  (5, 5, 'Transporte - Comunic.'),
  (6, 6, 'PrestaÃ§Ã£o de ServiÃ§os'),
  (7, 7, 'Atividade social'),
  (8, 8, 'AdministraÃ§Ã£o PÃºblica'),
  (9, 9, 'Outras atividades'),
  (10, 10, 'Inativos'),
  (11, 11, 'Atividade DomÃ©stica');


INSERT INTO activity_statuses (id, code, description) VALUES
  (1, 1, 'Empregado com carteira assinada'),
  (2, 2, 'Empregado sem carteira assinada'),
  (3, 3, 'FuncionÃ¡rio pÃºblico'),
  (4, 4, 'Conta prÃ³pria'),
  (5, 5, 'Empregador'),
  (6, 6, 'NÃ£o remunerado'),
  (7, 7, 'Aposentado/Pensionista'),
  (8, 8, 'Desempregado'),
  (9, 9, 'Estudante'),
  (10, 10, 'Do lar'),
  (11, 11, 'Outros'),
  (12, 88888, 'NÃ£o sabe'),
  (13, 98888, 'NÃ£o respondeu');


INSERT INTO activity_statuses_extended (id, code, description) VALUES
  (1, 1, 'Empregado'),
  (2, 2, 'PatrÃ£o'),
  (3, 3, 'Conta prÃ³pria'),
  (4, 4, 'NÃ£o aplicÃ¡vel');


INSERT INTO age_ranges (id, survey_id, code, description, min_age, max_age) VALUES
  (1, 1, '1', '16 a 24 anos', 16, 24),
  (2, 1, '2', '25 a 34 anos', 25, 34),
  (3, 1, '3', '35 a 44 anos', 35, 44),
  (4, 1, '4', '45 a 54 anos', 45, 54),
  (5, 1, '5', '55 anos ou mais', 55, NULL),
  (6, 2, '1', '21 a 30 anos', 21, 30),
  (7, 2, '2', '31 a 40 anos', 31, 40),
  (8, 2, '3', '41 a 50 anos', 41, 50),
  (9, 2, '4', '51 a 60 anos', 51, 60),
  (10, 2, '5', '61 a 70 anos', 61, 70),
  (11, 2, '6', '71 anos e mais', 71, NULL);




INSERT INTO city_sizes (id, code, description) VALUES
  (1, 1, 'AtÃ© 20 mil habitantes'),
  (2, 2, 'Mais de 20 a 100 mil habitantes'),
  (3, 3, 'Mais de 100 a 500 mil habitantes'),
  (4, 4, 'Mais de 500 mil a 1 milhÃ£o de habitantes'),
  (5, 5, 'Mais de 1 milhÃ£o a 5 milhÃµes de habitantes'),
  (6, 6, 'Mais de 5 milhÃµes de habitantes'),
  (7, 7, 'RegiÃ£o Metropolitana');


INSERT INTO education_levels (id, code, description, level_order) VALUES
  (1, 1, 'Analfabeto', 1),
  (2, 2, 'Sabe ler/escrever, mas nÃ£o cursou escola', 2),
  (3, 3, 'PrÃ©-escola (ou 1Âº ano do fundamental)', 3),
  (4, 4, '1Âª sÃ©rie (ou 2Âº ano) do fundamental', 4),
  (5, 5, '2Âª sÃ©rie (ou 3Âº ano) do fundamental', 5),
  (6, 6, '3Âª sÃ©rie (ou 4Âº ano) do fundamental', 6),
  (7, 7, '4Âª sÃ©rie (ou 5Âº ano) do fundamental', 7),
  (8, 8, '5Âª sÃ©rie (ou 6Âº ano) do fundamental', 8),
  (9, 9, '6Âª sÃ©rie (ou 7Âº ano) do fundamental', 9),
  (10, 10, '7Âª sÃ©rie (ou 8Âº ano) do fundamental', 10),
  (11, 11, '8Âª sÃ©rie (ou 9Âº ano) do fundamental', 11),
  (12, 12, '1Âº ano do ensino mÃ©dio (ou 2Âº grau)', 12),
  (13, 13, '2Âº ano do ensino mÃ©dio (ou 2Âº grau)', 13),
  (14, 14, '3Âº ano do ensino mÃ©dio (ou 2Âº grau)', 14),
  (15, 15, 'Ensino superior incompleto', 15),
  (16, 16, 'Ensino superior completo', 16),
  (17, 17, 'PÃ³s-graduaÃ§Ã£o', 17);


INSERT INTO first_round_candidates (id, code, description) VALUES
  (1744, 1, 'Ciro Gomes (PDT)'),
  (1746, 3, 'Felipe Dâ€™Avila (NOVO)'),
  (1747, 4, 'Jair Bolsonaro (PL)'),
  (1749, 6, 'Lula (PT)'),
  (1750, 7, 'Padre Kelmon (PTB)'),
  (1751, 8, 'Simone Tebet (MDB)'),
  (1752, 9, 'Sofia Manzano (PCB)'),
  (1753, 10, 'Soraya Thronicke (UNIÃO BRASIL)'),
  (1754, 11, 'Vera (PSTU)'),
  (1755, 12, 'Anulou o voto'),
  (1756, 13, 'Votou em branco'),
  (1757, 88888, 'NÃ£o sabe'),
  (1758, 98888, 'NÃ£o respondeu');


INSERT INTO genders (id, code, description) VALUES
  (1, 1, 'Masculino'),
  (2, 2, 'Feminino');


INSERT INTO income_ranges (id, code, description) VALUES
  (1, 1, 'Mais de R$ 30.360,01 / Mais de 20 SM'),
  (2, 2, 'Mais de R$ 15.180,01 atÃ© R$ 30.360,00 / Mais de 10 a 20 SM'),
  (3, 3, 'Mais de R$ 7.590,01 atÃ© R$ 15.180,00 / Mais de 5 a 10 SM'),
  (4, 4, 'Mais de R$ 3.036,01 atÃ© R$ 7.590,00 / Mais de 2 a 5 SM'),
  (5, 5, 'Mais de R$ 1.518,01 atÃ© R$ 3.036,00 / Mais de 1 a 2 SM'),
  (6, 6, 'AtÃ© R$ 1.518,00 / AtÃ© 1 salÃ¡rio mÃ­nimo'),
  (98, 98, 'NÃ£o tem rendimento pessoal'),
  (99, 99, 'NÃ£o respondeu');


INSERT INTO literacy_levels (id, code, description) VALUES
  (1, 1, 'Alfabetizado'),
  (2, 2, 'NÃ£o alfabetizado');


INSERT INTO occupations (id, code, description) VALUES
  (1, 1, 'Dirigentes'),
  (2, 2, 'Profissionais das ciÃªncias e das artes'),
  (3, 3, 'TÃ©cnicos de nÃ­vel mÃ©dio'),
  (4, 4, 'Trabalhadores de serviÃ§os administrativos'),
  (5, 5, 'Trabalhadores dos serviÃ§os'),
  (6, 6, 'Vendedores e prestadores de serviÃ§os do comÃ©rcio'),
  (7, 7, 'Trabalhadores agropecuÃ¡rios'),
  (8, 8, 'Trabalhadores da produÃ§Ã£o de bens e serviÃ§os'),
  (9, 9, 'Trabalhadores da produÃ§Ã£o de bens e serviÃ§os industriais'),
  (10, 10, 'Membros das forÃ§as armadas'),
  (11, 11, 'Outras ocupaÃ§Ãµes'),
  (12, 88888, 'NÃ£o sabe'),
  (13, 98888, 'NÃ£o respondeu');






INSERT INTO races (id, code, description) VALUES
  (1, 1, 'Branca'),
  (2, 2, 'Preta'),
  (3, 3, 'Parda'),
  (4, 4, 'Amarela'),
  (5, 5, 'IndÃ­gena'),
  (6, 6, 'Outra'),
  (7, 999, 'NÃ£o respondeu');


INSERT INTO regions (id, code, name) VALUES
  (1, 1, 'Norte'),
  (2, 2, 'Nordeste'),
  (3, 3, 'Sudeste'),
  (4, 4, 'Sul'),
  (5, 5, 'Centro-Oeste');


INSERT INTO religions (id, survey_id, code, description) VALUES
  (1, 1, 1, 'CatÃ³lica ApostÃ³lica Romana'),
  (2, 1, 2, 'EvangÃ©lica/Protestante'),
  (3, 1, 3, 'EspÃ­rita/Kardecista'),
  (4, 1, 4, 'Afro-brasileira (Umbanda, CandomblÃ©)'),
  (5, 1, 5, 'Outras religiÃµes'),
  (6, 1, 6, 'Sem religiÃ£o'),
  (7, 2, 1, 'CatÃ³lica ApostÃ³lica Romana'),
  (8, 2, 2, 'Assembleia de Deus'),
  (9, 2, 3, 'Batista | Metodista | Presbiteriana'),
  (10, 2, 4, 'Universal do Reino de Deus'),
  (11, 2, 5, 'Deus Ã© Amor'),
  (12, 2, 6, 'Evangelho Quadrangular'),
  (13, 2, 7, 'Igreja Internacional da GraÃ§a'),
  (14, 2, 8, 'Renascer em Cristo'),
  (15, 2, 9, 'Sara nossa terra'),
  (16, 2, 10, 'Outras EvangÃ©licas especÃ­ficas'),
  (17, 2, 11, 'EvangÃ©lica - NÃ£o sabe especificar'),
  (18, 2, 12, 'Adventista'),
  (19, 2, 13, 'Testemunha de JeovÃ¡'),
  (20, 2, 14, 'JudaÃ­ca'),
  (21, 2, 15, 'EspÃ­rita | Kardecista'),
  (22, 2, 16, 'Afro-Brasileiras (Umbanda, CandomblÃ©, etc)'),
  (23, 2, 17, 'Orientais (Budismo, Islamismo, etc)'),
  (24, 2, 18, 'Outras religiÃµes'),
  (25, 2, 19, 'Ã‰ religioso mas nÃ£o segue nenhuma | AgnÃ³stico'),
  (26, 2, 20, 'Ateu, nÃ£o tem religiÃ£o'),
  (27, 2, 99, 'NÃ£o respondeu');


INSERT INTO second_round_candidates (id, code, description) VALUES
  (1759, 1, 'Jair Bolsonaro'),
  (1760, 2, 'Lula'),
  (1761, 50, 'Anulou o voto'),
  (1762, 60, 'Votou em branco'),
  (1763, 88888, 'NÃ£o sabe'),
  (1764, 98888, 'NÃ£o respondeu');


INSERT INTO states (id, code, name, region_id) VALUES
  (1, 11, 'RondÃ´nia', 1),
  (2, 12, 'Acre', 1),
  (3, 13, 'Amazonas', 1),
  (4, 14, 'Roraima', 1),
  (5, 15, 'ParÃ¡', 1),
  (6, 16, 'AmapÃ¡', 1),
  (7, 17, 'Tocantins', 1),
  (8, 21, 'MaranhÃ£o', 2),
  (9, 22, 'PiauÃ­', 2),
  (10, 23, 'CearÃ¡', 2),
  (11, 24, 'Rio Grande do Norte', 2),
  (12, 25, 'ParaÃ­ba', 2),
  (13, 26, 'Pernambuco', 2),
  (14, 27, 'Alagoas', 2),
  (15, 28, 'Sergipe', 2),
  (16, 29, 'Bahia', 2),
  (17, 31, 'Minas Gerais', 3),
  (18, 32, 'EspÃ­rito Santo', 3),
  (19, 33, 'Rio de Janeiro', 3),
  (20, 35, 'SÃ£o Paulo', 3),
  (21, 41, 'ParanÃ¡', 4),
  (22, 42, 'Santa Catarina', 4),
  (23, 43, 'Rio Grande do Sul', 4),
  (24, 50, 'Mato Grosso do Sul', 5),
  (25, 51, 'Mato Grosso', 5),
  (26, 52, 'GoiÃ¡s', 5),
  (27, 53, 'Distrito Federal', 5);


INSERT INTO surveys (id, code, description) VALUES
  (1, 1, 'VisÃµes'),
  (2, 2, 'Deputados');


INSERT INTO political_parties (id, code, name) VALUES
  (1, 1, 'AVANTE'),
  (2, 2, 'CIDADANIA'),
  (3, 3, 'MDB'),
  (4, 4, 'NOVO'),
  (5, 5, 'PC DO B'),
  (6, 6, 'PDT'),
  (7, 7, 'PL'),
  (8, 8, 'PODE/ PODEMOS (+PSC)'),
  (9, 9, 'PP'),
  (10, 10, 'PRD (PTB+PATRIOTA)'),
  (11, 11, 'PSB'),
  (12, 12, 'PSD'),
  (13, 13, 'PSDB'),
  (14, 14, 'PSOL'),
  (15, 15, 'PT'),
  (16, 16, 'PTB'),
  (17, 17, 'PV'),
  (18, 18, 'REDE'),
  (19, 19, 'REPUBLICANOS'),
  (20, 20, 'SOLIDARIEDADE (+PROS)'),
  (21, 21, 'UNIÃƒO');
