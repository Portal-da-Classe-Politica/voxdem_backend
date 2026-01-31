// Mock do AppDataSource para testes
export const mockAppDataSource = {
  initialize: jest.fn().mockResolvedValue(undefined),
  query: jest.fn(),
  getRepository: jest.fn(),
  isInitialized: true,
  destroy: jest.fn().mockResolvedValue(undefined),
};

// Mock data para surveys
export const mockSurveys = [
  { id: 1, code: 'VOXDEM', description: 'Pesquisa Voxdem Brasil' },
  { id: 2, code: 'DEPUTADOS', description: 'Pesquisa Deputados Federais' },
];

// Mock data para questions
export const mockQuestions = [
  {
    code: 'P1',
    text: 'Satisfação com a democracia',
    surveyId: 2,
    totalResponses: 513,
  },
  {
    code: 'P3_1',
    text: 'Que as eleições nacionais sejam livres e justas.',
    surveyId: 2,
    totalResponses: 513,
  },
  {
    code: 'P4',
    text: 'Autoposicionamento Ideológico',
    surveyId: 2,
    totalResponses: 513,
  },
];

// Mock data para profile attributes
export const mockProfileAttributes = [
  {
    key: 'gender',
    name: 'Gênero',
    description: 'Gênero do respondente',
    column: 'gender',
  },
  {
    key: 'political_party',
    name: 'Partido Político',
    description: 'Partido político (Deputados)',
    column: 'political_party',
  },
];

// Mock data para chart data (simple)
export const mockChartDataSimple = {
  question: {
    code: 'P1',
    text: 'Satisfação com a democracia',
  },
  chartData: {
    labels: ['Muito satisfeito', 'Satisfeito', 'Pouco satisfeito', 'Nada satisfeito'],
    labelsDetailed: [
      { code: '1', label: 'Muito satisfeito' },
      { code: '2', label: 'Satisfeito' },
      { code: '3', label: 'Pouco satisfeito' },
      { code: '4', label: 'Nada satisfeito' },
    ],
    datasets: [
      {
        data: [50, 150, 200, 113],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
        borderColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
        borderWidth: 1,
      },
    ],
  },
  totalResponses: 513,
};

// Mock data para chart data with profile
export const mockChartDataWithProfile = {
  question: {
    code: 'P1',
    text: 'Satisfação com a democracia',
  },
  profileAttribute: {
    key: 'political_party',
    name: 'Partido Político',
  },
  chartData: {
    labels: ['Muito satisfeito', 'Satisfeito', 'Pouco satisfeito', 'Nada satisfeito'],
    labelsDetailed: [
      { code: '1', label: 'Muito satisfeito' },
      { code: '2', label: 'Satisfeito' },
      { code: '3', label: 'Pouco satisfeito' },
      { code: '4', label: 'Nada satisfeito' },
    ],
    datasets: [
      {
        label: 'PT',
        data: [10, 30, 40, 20],
        backgroundColor: '#FF6384',
      },
      {
        label: 'PL',
        data: [5, 20, 35, 30],
        backgroundColor: '#36A2EB',
      },
    ],
  },
  profileValues: ['PT', 'PL'],
  totalResponses: 190,
};
