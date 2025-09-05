// JSON com perguntas completas extraídas do arquivo de rótulos
// Estrutura: código da pergunta, rótulo (texto da pergunta) e valores rotulados (códigos e descrições das respostas)

export const PERGUNTAS_COM_VALORES = [
  {
    "cod": "P01",
    "rotulo": "De uma maneira geral, o(a) Sr.(a) está muito satisfeito(a), satisfeito(a), insatisfeito(a) ou muito insatisfeito(a) com o funcionamento da democracia no Brasil?",
    "categoria": "DEMOCRACIA",
    "tipo": "categorical",
    "valores": {
      "1": "Muito satisfeito",
      "2": "Satisfeito", 
      "3": "Nem satisfeito, nem insatisfeito (espontânea)",
      "4": "Insatisfeito",
      "5": "Muito insatisfeito",
      "88888": "Não sabe",
      "98888": "Não respondeu"
    }
  },
  {
    "cod": "P02",
    "rotulo": "Para o(a) Sr.(a), o que é democracia?",
    "categoria": "DEMOCRACIA",
    "tipo": "text",
    "valores": {
      "0": "0 - Não é importante para a democracia em geral",
      "10": "10 - É extremamente importante para democracia em geral"
    }
  },
  {
    "cod": "P73",
    "rotulo": "O(a) sr.(a) foi vítima de algum tipo de crime nos últimos doze meses?",
    "categoria": "SEGURANCA_CRIME",
    "tipo": "categorical",
    "valores": {
      "1": "Sim",
      "2": "Não",
      "88888": "Não sabe",
      "98888": "Não respondeu"
    }
  },
  {
    "cod": "P74",
    "rotulo": "Alguma outra pessoa que mora na sua casa foi vítima de algum tipo de crime nos últimos doze meses?",
    "categoria": "SEGURANCA_CRIME", 
    "tipo": "categorical",
    "valores": {
      "1": "Sim",
      "2": "Não",
      "88888": "Não sabe",
      "98888": "Não respondeu"
    }
  },
  {
    "cod": "P75",
    "rotulo": "Falando do lugar ou bairro onde o(a) sr.(a) vive, e pensando na possibilidade de ser vítima de um assalto ou roubo, o(a) sr./sra. se sente muito seguro(a), pouco seguro(a), pouco inseguro(a) ou muito inseguro(a)?",
    "categoria": "SEGURANCA_CRIME",
    "tipo": "categorical", 
    "valores": {
      "1": "Muito seguro(a)",
      "2": "Pouco seguro(a)",
      "3": "Pouco inseguro(a)",
      "4": "Muito inseguro(a)",
      "88888": "Não sabe",
      "98888": "Não respondeu"
    }
  },
  {
    "cod": "P76",
    "rotulo": "Se o(a) sr. /sra. fosse vítima de um roubo ou assalto, o quanto confiaria que o sistema judiciário puniria o culpado?",
    "categoria": "SEGURANCA_CRIME",
    "tipo": "escala_0_10",
    "valores": {
      "0": "0 - Não confiaria nada",
      "5": "5 - Confiaria mais ou menos",
      "10": "10 - Confiaria totalmente",
      "888": "Não sabe",
      "88888": "Não sabe",
      "98888": "Não respondeu",
      "999": "Não respondeu"
    }
  }
];

// Estatísticas do JSON extraído:
// - Total de perguntas com valores: 41
// - Tipos: categorical, escala_0_10, text
// - Categorias: DEMOCRACIA, SEGURANCA_CRIME, COMPORTAMENTO_POLITICO, MEIO_AMBIENTE, etc.
// - Valores especiais: 88888 (Não sabe), 98888 (Não respondeu), 999 (Não respondeu)

console.log('PERGUNTAS_COM_VALORES carregadas:', PERGUNTAS_COM_VALORES.length, 'perguntas');
