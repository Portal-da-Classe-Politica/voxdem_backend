
INSERT INTO activity_sectors (id, code, description) VALUES
  (1, 1, 'Agricultura, pecuária, silvicultura e pesca'),
  (2, 2, 'Indústria'),
  (3, 3, 'Construção'),
  (4, 4, 'Comércio e reparação'),
  (5, 5, 'Transporte, armazenagem e comunicação'),
  (6, 6, 'Alojamento e alimentação'),
  (7, 7, 'Intermediação financeira'),
  (8, 8, 'Atividades imobiliárias e serviços'),
  (9, 9, 'Administração pública'),
  (10, 10, 'Educação'),
  (11, 11, 'Saúde e serviços sociais'),
  (12, 12, 'Outros serviços coletivos, sociais e pessoais'),
  (13, 13, 'Serviços domésticos'),
  (14, 14, 'Organismos internacionais'),
  (15, 88888, 'Não sabe'),
  (16, 98888, 'Não respondeu');


INSERT INTO activity_sectors_extended (id, code, description) VALUES
  (1, 1, 'Agricultura'),
  (2, 2, 'Indúst. Transformação'),
  (3, 3, 'Construção - Outras'),
  (4, 4, 'Comércio'),
  (5, 5, 'Transporte - Comunic.'),
  (6, 6, 'Prestação de Serviços'),
  (7, 7, 'Atividade social'),
  (8, 8, 'Administração Pública'),
  (9, 9, 'Outras atividades'),
  (10, 10, 'Inativos'),
  (11, 11, 'Atividade Doméstica');


INSERT INTO activity_statuses (id, code, description) VALUES
  (1, 1, 'Empregado com carteira assinada'),
  (2, 2, 'Empregado sem carteira assinada'),
  (3, 3, 'Funcionário público'),
  (4, 4, 'Conta própria'),
  (5, 5, 'Empregador'),
  (6, 6, 'Não remunerado'),
  (7, 7, 'Aposentado/Pensionista'),
  (8, 8, 'Desempregado'),
  (9, 9, 'Estudante'),
  (10, 10, 'Do lar'),
  (11, 11, 'Outros'),
  (12, 88888, 'Não sabe'),
  (13, 98888, 'Não respondeu');


INSERT INTO activity_statuses_extended (id, code, description) VALUES
  (1, 1, 'Empregado'),
  (2, 2, 'Patrão'),
  (3, 3, 'Conta própria'),
  (4, 4, 'Não aplicável');


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
  (1, 1, 'Até 20 mil habitantes'),
  (2, 2, 'Mais de 20 a 100 mil habitantes'),
  (3, 3, 'Mais de 100 a 500 mil habitantes'),
  (4, 4, 'Mais de 500 mil a 1 milhão de habitantes'),
  (5, 5, 'Mais de 1 milhão a 5 milhões de habitantes'),
  (6, 6, 'Mais de 5 milhões de habitantes'),
  (7, 7, 'Região Metropolitana');


INSERT INTO education_levels (id, code, description, level_order) VALUES
  (1, 1, 'Analfabeto', 1),
  (2, 2, 'Sabe ler/escrever, mas não cursou escola', 2),
  (3, 3, 'Pré-escola (ou 1Âº ano do fundamental)', 3),
  (4, 4, '1Âª série (ou 2Âº ano) do fundamental', 4),
  (5, 5, '2Âª série (ou 3Âº ano) do fundamental', 5),
  (6, 6, '3Âª série (ou 4Âº ano) do fundamental', 6),
  (7, 7, '4Âª série (ou 5Âº ano) do fundamental', 7),
  (8, 8, '5Âª série (ou 6Âº ano) do fundamental', 8),
  (9, 9, '6Âª série (ou 7Âº ano) do fundamental', 9),
  (10, 10, '7Âª série (ou 8Âº ano) do fundamental', 10),
  (11, 11, '8Âª série (ou 9Âº ano) do fundamental', 11),
  (12, 12, '1Âº ano do ensino médio (ou 2Âº grau)', 12),
  (13, 13, '2Âº ano do ensino médio (ou 2Âº grau)', 13),
  (14, 14, '3Âº ano do ensino médio (ou 2Âº grau)', 14),
  (15, 15, 'Ensino superior incompleto', 15),
  (16, 16, 'Ensino superior completo', 16),
  (17, 17, 'Pós-graduação', 17);


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
  (1757, 88888, 'Não sabe'),
  (1758, 98888, 'Não respondeu');


INSERT INTO genders (id, code, description) VALUES
  (1, 1, 'Masculino'),
  (2, 2, 'Feminino');


INSERT INTO income_ranges (id, code, description) VALUES
  (1, 1, 'Mais de R$ 30.360,01 / Mais de 20 SM'),
  (2, 2, 'Mais de R$ 15.180,01 até R$ 30.360,00 / Mais de 10 a 20 SM'),
  (3, 3, 'Mais de R$ 7.590,01 até R$ 15.180,00 / Mais de 5 a 10 SM'),
  (4, 4, 'Mais de R$ 3.036,01 até R$ 7.590,00 / Mais de 2 a 5 SM'),
  (5, 5, 'Mais de R$ 1.518,01 até R$ 3.036,00 / Mais de 1 a 2 SM'),
  (6, 6, 'Até R$ 1.518,00 / Até 1 salário mínimo'),
  (98, 98, 'Não tem rendimento pessoal'),
  (99, 99, 'Não respondeu');


INSERT INTO literacy_levels (id, code, description) VALUES
  (1, 1, 'Alfabetizado'),
  (2, 2, 'Não alfabetizado');


INSERT INTO occupations (id, code, description) VALUES
  (1, 1, 'Dirigentes'),
  (2, 2, 'Profissionais das ciências e das artes'),
  (3, 3, 'Técnicos de nível médio'),
  (4, 4, 'Trabalhadores de serviços administrativos'),
  (5, 5, 'Trabalhadores dos serviços'),
  (6, 6, 'Vendedores e prestadores de serviços do comércio'),
  (7, 7, 'Trabalhadores agropecuários'),
  (8, 8, 'Trabalhadores da produção de bens e serviços'),
  (9, 9, 'Trabalhadores da produção de bens e serviços industriais'),
  (10, 10, 'Membros das forças armadas'),
  (11, 11, 'Outras ocupações'),
  (12, 88888, 'Não sabe'),
  (13, 98888, 'Não respondeu');






INSERT INTO races (id, code, description) VALUES
  (1, 1, 'Branca'),
  (2, 2, 'Preta'),
  (3, 3, 'Parda'),
  (4, 4, 'Amarela'),
  (5, 5, 'Indígena'),
  (6, 6, 'Outra'),
  (7, 999, 'Não respondeu');


INSERT INTO regions (id, code, name) VALUES
  (1, 1, 'Norte'),
  (2, 2, 'Nordeste'),
  (3, 3, 'Sudeste'),
  (4, 4, 'Sul'),
  (5, 5, 'Centro-Oeste');


INSERT INTO religions (id, survey_id, code, description) VALUES
  (1, 1, 1, 'Católica Apostólica Romana'),
  (2, 1, 2, 'Evangélica/Protestante'),
  (3, 1, 3, 'Espírita/Kardecista'),
  (4, 1, 4, 'Afro-brasileira (Umbanda, Candomblé)'),
  (5, 1, 5, 'Outras religiões'),
  (6, 1, 6, 'Sem religião'),
  (7, 2, 1, 'Católica Apostólica Romana'),
  (8, 2, 2, 'Assembleia de Deus'),
  (9, 2, 3, 'Batista | Metodista | Presbiteriana'),
  (10, 2, 4, 'Universal do Reino de Deus'),
  (11, 2, 5, 'Deus é Amor'),
  (12, 2, 6, 'Evangelho Quadrangular'),
  (13, 2, 7, 'Igreja Internacional da Graça'),
  (14, 2, 8, 'Renascer em Cristo'),
  (15, 2, 9, 'Sara nossa terra'),
  (16, 2, 10, 'Outras Evangélicas específicas'),
  (17, 2, 11, 'Evangélica - Não sabe especificar'),
  (18, 2, 12, 'Adventista'),
  (19, 2, 13, 'Testemunha de Jeová'),
  (20, 2, 14, 'Judaíca'),
  (21, 2, 15, 'Espírita | Kardecista'),
  (22, 2, 16, 'Afro-Brasileiras (Umbanda, Candomblé, etc)'),
  (23, 2, 17, 'Orientais (Budismo, Islamismo, etc)'),
  (24, 2, 18, 'Outras religiões'),
  (25, 2, 19, 'É religioso mas não segue nenhuma | Agnóstico'),
  (26, 2, 20, 'Ateu, não tem religião'),
  (27, 2, 99, 'Não respondeu');


INSERT INTO second_round_candidates (id, code, description) VALUES
  (1759, 1, 'Jair Bolsonaro'),
  (1760, 2, 'Lula'),
  (1761, 50, 'Anulou o voto'),
  (1762, 60, 'Votou em branco'),
  (1763, 88888, 'Não sabe'),
  (1764, 98888, 'Não respondeu');


INSERT INTO states (id, code, name, region_id) VALUES
  (1, 11, 'Rondônia', 1),
  (2, 12, 'Acre', 1),
  (3, 13, 'Amazonas', 1),
  (4, 14, 'Roraima', 1),
  (5, 15, 'Pará', 1),
  (6, 16, 'Amapá', 1),
  (7, 17, 'Tocantins', 1),
  (8, 21, 'Maranhão', 2),
  (9, 22, 'Piauí', 2),
  (10, 23, 'Ceará', 2),
  (11, 24, 'Rio Grande do Norte', 2),
  (12, 25, 'Paraíba', 2),
  (13, 26, 'Pernambuco', 2),
  (14, 27, 'Alagoas', 2),
  (15, 28, 'Sergipe', 2),
  (16, 29, 'Bahia', 2),
  (17, 31, 'Minas Gerais', 3),
  (18, 32, 'Espírito Santo', 3),
  (19, 33, 'Rio de Janeiro', 3),
  (20, 35, 'São Paulo', 3),
  (21, 41, 'Paraná', 4),
  (22, 42, 'Santa Catarina', 4),
  (23, 43, 'Rio Grande do Sul', 4),
  (24, 50, 'Mato Grosso do Sul', 5),
  (25, 51, 'Mato Grosso', 5),
  (26, 52, 'Goiás', 5),
  (27, 53, 'Distrito Federal', 5);


INSERT INTO surveys (id, code, description) VALUES
  (1, 1, 'Visões'),
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
  (21, 21, 'UNIÃO');
