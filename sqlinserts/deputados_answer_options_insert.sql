-- =====================================================
-- Deputados Answer Options Insert
-- =====================================================
-- Opções de resposta específicas para as perguntas dos deputados

INSERT INTO public.answer_options (id, answer_group_id, code, label, option_order) VALUES
    -- Answer Group 100 - Satisfação com a democracia
    (1497, 100, 1, 'Muito satisfeito', 1),
    (1498, 100, 2, 'Satisfeito', 2),
    (1499, 100, 3, 'Nem satisfeito, nem insatisfeito (espontânea)', 3),
    (1500, 100, 4, 'Insatisfeito', 4),
    (1501, 100, 5, 'Muito insatisfeito', 5),
    (1502, 100, 88888, 'Não sabe', 6),
    (1503, 100, 98888, 'Não respondeu', 7),
    
    -- Answer Group 101 - Importância para a democracia (0-10)
    (1886, 101, 1, 'Pouco importante para a democracia', 1),
    (1887, 101, 2, 'Pouco importante para a democracia', 2),
    (1888, 101, 3, 'Pouco importante para a democracia', 3),
    (1889, 101, 4, 'Pouco importante para a democracia', 4),
    (1890, 101, 5, 'Neutro/Moderadamente importante', 5),
    (1891, 101, 6, 'Importante para a democracia', 6),
    (1892, 101, 7, 'Importante para a democracia', 7),
    (1893, 101, 8, 'Muito importante para a democracia', 8),
    (1894, 101, 9, 'Muito importante para a democracia', 9),
    (1504, 101, 0, 'Não é importante para a democracia em geral', 10),
    (1505, 101, 10, 'É extremamente importante para democracia em geral', 11),
    (1506, 101, 888, 'Não sabe', 12),
    (1507, 101, 999, 'Não respondeu', 13),
    
    -- Answer Group 102 - Concordância com afirmações (0-10)
    (1895, 102, 1, 'Discorda muito', 1),
    (1896, 102, 2, 'Discorda muito', 2),
    (1897, 102, 3, 'Discorda parcialmente', 3),
    (1898, 102, 4, 'Discorda parcialmente', 4),
    (1899, 102, 5, 'Neutro/Indiferente', 5),
    (1900, 102, 6, 'Concorda parcialmente', 6),
    (1901, 102, 7, 'Concorda parcialmente', 7),
    (1902, 102, 8, 'Concorda muito', 8),
    (1903, 102, 9, 'Concorda muito', 9),
    (1508, 102, 0, 'Discorda totalmente', 10),
    (1509, 102, 10, 'Concorda totalmente', 11),
    (1510, 102, 888, 'Não sabe', 12),
    (1511, 102, 999, 'Não respondeu', 13),
    
    -- Answer Group 103 - Avaliação de partidos (0-10)
    (1904, 103, 1, 'Avaliação muito negativa', 1),
    (1905, 103, 2, 'Avaliação muito negativa', 2),
    (1906, 103, 3, 'Avaliação negativa', 3),
    (1907, 103, 4, 'Avaliação negativa', 4),
    (1908, 103, 5, 'Avaliação neutra', 5),
    (1909, 103, 6, 'Avaliação positiva', 6),
    (1910, 103, 7, 'Avaliação positiva', 7),
    (1911, 103, 8, 'Avaliação muito positiva', 8),
    (1912, 103, 9, 'Avaliação muito positiva', 9),
    (1512, 103, 0, 'Não gosta do partido de jeito nenhum', 10),
    (1513, 103, 10, 'Gosta muito do partido', 11),
    (1514, 103, 888, 'Não sabe', 12),
    (1515, 103, 999, 'Não respondeu', 13),
    
    -- Answer Group 107 - Avaliação de políticos (0-10)
    (1913, 107, 1, 'Gosta muito pouco', 1),
    (1914, 107, 2, 'Gosta muito pouco', 2),
    (1915, 107, 3, 'Gosta pouco', 3),
    (1916, 107, 4, 'Gosta pouco', 4),
    (1917, 107, 5, 'Neutro/Indiferente', 5),
    (1918, 107, 6, 'Gosta', 6),
    (1919, 107, 7, 'Gosta', 7),
    (1920, 107, 8, 'Gosta muito', 8),
    (1921, 107, 9, 'Gosta muito', 9),
    (1560, 107, 0, 'Não gosta do político de jeito nenhum', 10),
    (1561, 107, 10, 'Gosta muito do político', 11),
    (1562, 107, 888, 'Não sabe', 12),
    (1563, 107, 999, 'Não respondeu', 13),
    
    -- Answer Group 109 - Autoposicionamento ideológico (0-10)
    (1949, 109, 1, 'Escala política (0 esquerda - 10 direita)', 1),
    (1950, 109, 2, 'Escala política (0 esquerda - 10 direita)', 2),
    (1951, 109, 3, 'Escala política (0 esquerda - 10 direita)', 3),
    (1952, 109, 4, 'Escala política (0 esquerda - 10 direita)', 4),
    (1953, 109, 5, 'Escala política (0 esquerda - 10 direita)', 5),
    (1954, 109, 6, 'Escala política (0 esquerda - 10 direita)', 6),
    (1955, 109, 7, 'Escala política (0 esquerda - 10 direita)', 7),
    (1956, 109, 8, 'Escala política (0 esquerda - 10 direita)', 8),
    (1957, 109, 9, 'Escala política (0 esquerda - 10 direita)', 9),
    (1570, 109, 0, 'Esquerda', 10),
    (1571, 109, 10, 'Direita', 11),
    (1572, 109, 888, 'Não sabe', 12),
    (1573, 109, 999, 'Não respondeu', 13),
    
    -- Answer Group 118 - Escala de preocupação (0-10)
    (1922, 118, 1, 'Muito pouco preocupado', 1),
    (1923, 118, 2, 'Muito pouco preocupado', 2),
    (1924, 118, 3, 'Pouco preocupado', 3),
    (1925, 118, 4, 'Pouco preocupado', 4),
    (1926, 118, 5, 'Moderadamente preocupado', 5),
    (1927, 118, 6, 'Preocupado', 6),
    (1928, 118, 7, 'Preocupado', 7),
    (1929, 118, 8, 'Muito preocupado', 8),
    (1930, 118, 9, 'Muito preocupado', 9),
    (1619, 118, 0, 'Completamente despreocupado', 10),
    (1620, 118, 10, 'Extremamente preocupado', 11),
    (1621, 118, 888, 'Não sabe', 12),
    (1622, 118, 999, 'Não respondeu', 13),
    
    -- Answer Group 122 - Escala de importância (0-10)
    (1931, 122, 1, 'Muito pouco importante', 1),
    (1932, 122, 2, 'Muito pouco importante', 2),
    (1933, 122, 3, 'Pouco importante', 3),
    (1934, 122, 4, 'Pouco importante', 4),
    (1935, 122, 5, 'Moderadamente importante', 5),
    (1936, 122, 6, 'Importante', 6),
    (1937, 122, 7, 'Importante', 7),
    (1938, 122, 8, 'Muito importante', 8),
    (1939, 122, 9, 'Muito importante', 9),
    (1640, 122, 0, 'Nada importante', 10),
    (1641, 122, 10, 'Muito importante', 11),
    (1642, 122, 888, 'Não sabe', 12),
    (1643, 122, 999, 'Não respondeu', 13),
    
    -- Answer Group 132 - Importância para Lula (0-10)
    (1940, 132, 1, 'Discorda totalmente do princípio', 1),
    (1941, 132, 2, 'Discorda muito do princípio', 2),
    (1942, 132, 3, 'Discorda do princípio', 3),
    (1943, 132, 4, 'Discorda parcialmente', 4),
    (1944, 132, 5, 'Neutro sobre o princípio', 5),
    (1945, 132, 6, 'Concorda parcialmente', 6),
    (1946, 132, 7, 'Concorda com o princípio', 7),
    (1947, 132, 8, 'Concorda muito', 8),
    (1948, 132, 9, 'Concorda totalmente com o princípio', 9),
    (1700, 132, 0, 'Para Lula não é importante', 10),
    (1701, 132, 10, 'Para Lula é extremamente importante', 11),
    (1702, 132, 888, 'Não sabe', 12),
    (1703, 132, 999, 'Não respondeu', 13);

-- Resetar a sequência
SELECT setval('answer_options_id_seq', (SELECT MAX(id) FROM answer_options));
