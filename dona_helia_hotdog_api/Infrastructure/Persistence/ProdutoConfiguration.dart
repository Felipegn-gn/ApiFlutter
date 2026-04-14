namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ProdutoConfiguration : IEntityTypeConfiguration<Produto>
{
    public void Configure(EntityTypeBuilder<Produto> builder)
    {
        builder.ToTable("Produtos");

        builder.HasKey(p => p.Id)
            .HasName("PK_Produtos");

        builder.Property(p => p.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(p => p.Nome)
            .IsRequired()
            .HasColumnName("Nome")
            .HasMaxLength(255);

        builder.Property(p => p.Descricao)
            .HasColumnName("Descricao")
            .HasMaxLength(500);

        builder.Property(p => p.PrecoBase)
            .IsRequired()
            .HasColumnName("PrecoBase")
            .HasColumnType("decimal(10,2)");

        builder.Property(p => p.ImagemUrl)
            .HasColumnName("ImagemUrl")
            .HasMaxLength(500);

        builder.Property(p => p.Ativo)
            .IsRequired()
            .HasColumnName("Ativo")
            .HasDefaultValue(true);

        builder.HasMany(p => p.ProdutoIngredientes)
            .WithOne(pi => pi.Produto)
            .HasForeignKey(pi => pi.ProdutoId)
            .HasConstraintName("FK_ProdutoIngredientes_Produtos")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(p => p.ItensPedido)
            .WithOne(ip => ip.Produto)
            .HasForeignKey(ip => ip.ProdutoId)
            .HasConstraintName("FK_ItensPedido_Produtos")
            .OnDelete(DeleteBehavior.Restrict);
    }
}
