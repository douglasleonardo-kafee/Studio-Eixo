-- ============================================================
-- 🧘‍♀️ STUDIO PILATES MANAGER - SCRIPT SQL DE CRIAÇÃO E DEMO (SUPABASE)
-- ============================================================
-- Instruções:
-- 1. Acesse o painel do seu projeto no Supabase (https://supabase.com).
-- 2. Vá até a seção "SQL Editor" na barra lateral esquerda.
-- 3. Cole todo o conteúdo deste arquivo e clique em "Run".
-- ============================================================

-- 1. LIMPEZA PREVENTIVA (Opcional, para recriação limpa)
DROP TABLE IF EXISTS public.agendamentos CASCADE;
DROP TABLE IF EXISTS public.clientes CASCADE;

-- 2. TABELA DE CLIENTES (ALUNOS)
CREATE TABLE public.clientes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome TEXT NOT NULL,
    telefone TEXT NOT NULL,
    valor_mensalidade NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    pago BOOLEAN NOT NULL DEFAULT false,
    aulas_repor INTEGER NOT NULL DEFAULT 0,
    observacoes TEXT DEFAULT '',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. TABELA DE AGENDAMENTOS (TURMAS E HORÁRIOS)
-- Nota: A regra de no máximo 4 alunos por turma é validada no aplicativo e pode ser forçada via trigger.
CREATE TABLE public.agendamentos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cliente_id UUID NOT NULL REFERENCES public.clientes(id) ON DELETE CASCADE,
    dia_semana TEXT NOT NULL, -- Ex: 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'
    horario TEXT NOT NULL,    -- Ex: '07:00', '08:00', '09:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. ÍNDICES DE DESEMPENHO
CREATE INDEX idx_agendamentos_dia_horario ON public.agendamentos(dia_semana, horario);
CREATE INDEX idx_agendamentos_cliente_id ON public.agendamentos(cliente_id);
CREATE INDEX idx_clientes_pago ON public.clientes(pago);

-- 5. POLÍTICAS DE SEGURANÇA (ROW LEVEL SECURITY - RLS)
ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agendamentos ENABLE ROW LEVEL SECURITY;

-- Permitir acesso total (Leitura, Inserção, Atualização, Exclusão) para a chave anônima/autenticada do app
CREATE POLICY "Permitir acesso completo a clientes"
ON public.clientes FOR ALL
USING (true)
WITH CHECK (true);

CREATE POLICY "Permitir acesso completo a agendamentos"
ON public.agendamentos FOR ALL
USING (true)
WITH CHECK (true);

-- 6. POVOAMENTO INICIAL DE DEMONSTRAÇÃO (SEED DATA)
INSERT INTO public.clientes (id, nome, telefone, valor_mensalidade, pago, aulas_repor, observacoes) VALUES
('c1000000-0000-0000-0000-000000000001', 'Ana Paula Silva', '(11) 98765-4321', 280.00, true, 0, 'Hérnia de disco L4-L5. Evitar extensão excessiva da coluna.'),
('c2000000-0000-0000-0000-000000000002', 'Carlos Eduardo Santos', '(11) 91234-5678', 250.00, false, 2, 'Foco em fortalecimento de joelho pós-cirurgia de LCA.'),
('c3000000-0000-0000-0000-000000000003', 'Mariana Oliveira', '(11) 99887-6655', 300.00, true, 1, 'Gestante (22ª semana). Foco em assoalho pélvico e postura.'),
('c4000000-0000-0000-0000-000000000004', 'Roberto Mendes', '(11) 97766-5544', 250.00, false, 3, 'Tendinite no ombro direito. Atenção aos exercícios de apoio.'),
('c5000000-0000-0000-0000-000000000005', 'Fernanda Costa', '(11) 96543-2109', 280.00, true, 0, 'Sem restrições físicas. Aluna avançada.'),
('c6000000-0000-0000-0000-000000000006', 'Lucas Lima', '(11) 95432-1098', 250.00, true, 0, 'Encaminhamento médico para lombalgia crônica.');

INSERT INTO public.agendamentos (cliente_id, dia_semana, horario) VALUES
('c1000000-0000-0000-0000-000000000001', 'Segunda-feira', '07:00'),
('c2000000-0000-0000-0000-000000000002', 'Segunda-feira', '07:00'),
('c3000000-0000-0000-0000-000000000003', 'Segunda-feira', '07:00'),
('c4000000-0000-0000-0000-000000000004', 'Segunda-feira', '08:00'),
('c5000000-0000-0000-0000-000000000005', 'Segunda-feira', '08:00'),
('c6000000-0000-0000-0000-000000000006', 'Segunda-feira', '08:00'),
('c1000000-0000-0000-0000-000000000001', 'Segunda-feira', '08:00'),
('c2000000-0000-0000-0000-000000000002', 'Terça-feira', '09:00'),
('c5000000-0000-0000-0000-000000000005', 'Terça-feira', '09:00'),
('c3000000-0000-0000-0000-000000000003', 'Quarta-feira', '17:00'),
('c4000000-0000-0000-0000-000000000004', 'Quarta-feira', '17:00');
