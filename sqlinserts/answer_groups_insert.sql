-- =====================================================
-- Answer Groups Insert
-- =====================================================
-- Insere os grupos de resposta para as perguntas
-- Este arquivo deve ser executado ANTES de voxdem_answer_options_insert.sql

-- Grupos para as perguntas gerais (população) - já existentes
INSERT INTO answer_groups (id, name, description) VALUES
(104, 'Party Opinion Scale', 'Escala de opinião sobre partidos (0-10)'),
(105, 'Yes/No', 'Respostas Sim/Não'),
(106, 'Political Parties', 'Lista de Partidos Políticos'),
(108, 'Political Interest', 'Nível de interesse político'),
(110, 'Trust Level', 'Nível de confiança'),
(111, 'Security Feeling', 'Sentimento de segurança'),
(112, 'Trust Scale', 'Escala de confiança'),
(113, 'Approval', 'Aprovação/Desaprovação'),
(114, 'Simple Approval', 'Aprovação/Desaprovação (simples)'),
(115, 'Climate Causes', 'Causas das mudanças climáticas'),
(116, 'Climate Frequency', 'Frequência de eventos climáticos'),
(117, 'Information Sharing', 'Compartilhamento de informações'),
(119, 'Public Services', 'Avaliação de serviços públicos'),
(120, 'Funding Preference', 'Preferência sobre financiamento'),
(121, 'Representation Definition', 'Definição de representação'),
(123, 'Honest vs Results', 'Preferência político honesto vs resultados'),
(124, 'Temporal Comparison', 'Comparação temporal'),
(125, 'Participation Frequency', 'Frequência de participação'),
(126, 'Residence Time', 'Tempo de residência'),
(127, 'Local Support', 'Apoio político local'),
(128, 'Politicians Knowledge', 'Conhecimento de políticos'),
(129, 'Followers Count', 'Quantidade de seguidores'),
(130, 'Political Polarization', 'Polarização política'),
(131, 'Violence Justification', 'Justificativa de violência'),
(133, 'Importance Scale 0-10', 'Escala de importância (0-10)'),
(134, 'Visual Trends', 'Opções visuais de tendência'),
(136, 'Should/Should Not', 'Deveria/Não deveria ser permitido'),
(137, 'Agreement Scale 1-10', 'Escala de concordância (1-10)'),
(138, 'Electoral Participation 1st', 'Participação eleitoral (1º turno)'),
(139, '2022 1st Round Candidates', 'Candidatos 1º turno 2022'),
(140, '2022 2nd Round Candidates', 'Candidatos 2º turno 2022'),
(141, 'Participation Willingness', 'Disposição para participação'),
(142, 'Participation Level', 'Nível de participação'),
(143, 'Country Priorities', 'Prioridades do país'),
(144, 'Information Truthfulness', 'Veracidade da informação'),
(145, 'Brazil Main Problems', 'Principais problemas do Brasil'),
(146, 'Occurrence Frequency', 'Frequência de ocorrência'),
(147, 'Corrupt Politicians Ratio', 'Proporção de políticos corruptos'),
(149, 'Experience Time', 'Tempo de experiência'),
(150, 'Residence History', 'Histórico de residência'),
(153, 'Childhood Religion', 'Religião de criação'),
(154, 'Sexual Orientation', 'Orientação sexual'),
(155, 'Comparative Scenarios', 'Cenários comparativos'),
(156, 'Employment Status', 'Situação de emprego'),
(157, 'Current Religion', 'Religião atual');

-- Grupos para as perguntas dos DEPUTADOS - novos grupos que faltavam
INSERT INTO answer_groups (id, name, description) VALUES
(100, 'Democracy Satisfaction', 'Satisfação com a democracia'),
(101, 'Democracy Importance 0-10', 'Importância para a democracia (0-10)'),
(102, 'Agreement Scale 0-10', 'Concordância com afirmações (0-10)'),
(103, 'Party Evaluation 0-10', 'Avaliação de partidos (0-10)'),
(107, 'Politicians Evaluation 0-10', 'Avaliação de políticos (0-10)'),
(109, 'Ideological Position 0-10', 'Autoposicionamento ideológico (0-10 esquerda-direita)'),
(118, 'Concern Scale 0-10', 'Escala de preocupação (0-10)'),
(122, 'Importance Scale 0-10 V2', 'Escala de importância (0-10)'),
(132, 'Lula Importance 0-10', 'Importância para Lula (0-10)');

-- Resetar a sequência para o próximo ID
SELECT setval('answer_groups_id_seq', (SELECT MAX(id) FROM answer_groups));
