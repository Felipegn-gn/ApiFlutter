namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class IngredienteConfiguration : IEntityTypeConfiguration<Ingrediente>
{
    public void Configure(EntityTypeBuilder<Ingrediente> builder)
    {
        builder.ToTable("Ingredientes");

        builder.HasKey(i => i.Id)
            .HasName("PK_Ingredientes");

        builder.Property(i => i.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(i => i.Nome)
            .IsRequired()
            .HasColumnName("Nome")
            .HasMaxLength(255);

        builder.HasMany(i => i.ProdutoIngredientes)
            .WithOne(pi => pi.Ingrediente)
            .HasForeignKey(pi => pi.IngredienteId)
            .HasConstraintName("FK_ProdutoIngredientes_Ingredientes")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(i => i.ItemPedidoRemocoes)
            .WithOne(ipr => ipr.Ingrediente)
            .HasForeignKey(ipr => ipr.IngredienteId)
            .HasConstraintName("FK_ItemPedidoRemocoes_Ingredientes")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
