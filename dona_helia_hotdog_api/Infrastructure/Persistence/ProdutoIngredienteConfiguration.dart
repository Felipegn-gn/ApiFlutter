namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ProdutoIngredienteConfiguration : IEntityTypeConfiguration<ProdutoIngrediente>
{
    public void Configure(EntityTypeBuilder<ProdutoIngrediente> builder)
    {
        builder.ToTable("ProdutoIngredientes");

        builder.HasKey(pi => pi.Id)
            .HasName("PK_ProdutoIngredientes");

        builder.Property(pi => pi.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(pi => pi.ProdutoId)
            .IsRequired()
            .HasColumnName("ProdutoId");

        builder.Property(pi => pi.IngredienteId)
            .IsRequired()
            .HasColumnName("IngredienteId");

        builder.HasIndex(pi => new { pi.ProdutoId, pi.IngredienteId })
            .IsUnique()
            .HasDatabaseName("IX_ProdutoIngredientes_ProdutoId_IngredienteId");

        builder.HasOne(pi => pi.Produto)
            .WithMany(p => p.ProdutoIngredientes)
            .HasForeignKey(pi => pi.ProdutoId)
            .HasConstraintName("FK_ProdutoIngredientes_Produtos")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(pi => pi.Ingrediente)
            .WithMany(i => i.ProdutoIngredientes)
            .HasForeignKey(pi => pi.IngredienteId)
            .HasConstraintName("FK_ProdutoIngredientes_Ingredientes")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
