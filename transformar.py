import os
import pandas as pd
from sqlalchemy import create_engine, text


# coonfig do banco

DB_USER = "root"
DB_PASSWORD = "12345"
DB_HOST = "localhost"
DB_PORT = 3306
DB_NAME = "LojaEletronicosPBI"  

# onde serao exportados os csv
PASTA_SAIDA = "CSV"

TABELAS = {
    "pedido": "pedido.csv",
    "cliente": "cliente.csv",
    "categoria": "categoria.csv",
    "entrega": "entrega.csv",
    "loja": "loja.csv",
    "item_pedido": "item_pedido.csv",
    "pagamento": "pagamento.csv",
    "produto": "produto.csv",
}

os.makedirs(PASTA_SAIDA, exist_ok=True)

engine = create_engine(
    f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}",
    pool_pre_ping=True,
)

def exportar_banco():
    with engine.connect() as conn:
       # confirmar se o banco conectou
        db_atual = conn.execute(text("SELECT DATABASE()")).scalar()
        print(f"✅ conectado no banco: {db_atual}")

        for tabela, arquivo in TABELAS.items():
            caminho = os.path.join(PASTA_SAIDA, arquivo)
            try:
                df = pd.read_sql(text(f"SELECT * FROM `{tabela}`"), conn)
                df.to_csv(caminho, index=False, encoding="utf-8-sig")
                print(f"✅ exportado: {tabela} -> {caminho} ({len(df)} linhas)")
            except Exception as e:
                print(f"❌ falhou na tabela '{tabela}': {e}")

if __name__ == "__main__":
    exportar_banco()
    print("Finalizado.")