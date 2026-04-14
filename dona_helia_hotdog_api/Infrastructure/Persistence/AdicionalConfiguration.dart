-- Reflete: builder.ToTable("Adicionais")
CREATE TABLE Adicionais (
    -- Reflete: builder.HasKey(a => a.Id) e ValueGeneratedNever()
    Id UUID PRIMARY KEY, 
    
    -- Reflete: .HasMaxLength(255) e .IsRequired()
    Nome VARCHAR(255) NOT NULL, 
    
    -- Reflete: .HasColumnType("decimal(10,2)")
    Preco DECIMAL(10,2) NOT NULL, 
    
    -- Reflete: .HasDefaultValue(true)
    Ativo BOOLEAN NOT NULL DEFAULT TRUE 
);

-- Reflete: builder.HasMany(a => a.ItensPedidoAdicional) com OnDelete(DeleteBehavior.Restrict)
ALTER TABLE ItensPedidoAdicionais
ADD CONSTRAINT FK_ItemPedidoAdicional_Adicionais
FOREIGN KEY (AdicionalId) REFERENCES Adicionais(Id)
ON DELETE RESTRICT;