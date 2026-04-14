namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ItemPedidoRemocaoConfiguration : IEntityTypeConfiguration<ItemPedidoRemocao>
{
    public void Configure(EntityTypeBuilder<ItemPedidoRemocao> builder)
    {
        builder.ToTable("ItemPedidoRemocoes");

        builder.HasKey(ipr => ipr.Id)
            .HasName("PK_ItemPedidoRemocoes");

        builder.Property(ipr => ipr.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(ipr => ipr.ItemPedidoId)
            .IsRequired()
            .HasColumnName("ItemPedidoId");

        builder.Property(ipr => ipr.IngredienteId)
            .IsRequired()
            .HasColumnName("IngredienteId");

        builder.HasIndex(ipr => new { ipr.ItemPedidoId, ipr.IngredienteId })
            .IsUnique()
            .HasDatabaseName("IX_ItemPedidoRemocoes_ItemPedidoId_IngredienteId");

        builder.HasOne(ipr => ipr.ItemPedido)
            .WithMany(ip => ip.Remocoes)
            .HasForeignKey(ipr => ipr.ItemPedidoId)
            .HasConstraintName("FK_ItemPedidoRemocoes_ItensPedido")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ipr => ipr.Ingrediente)
            .WithMany(i => i.ItemPedidoRemocoes)
            .HasForeignKey(ipr => ipr.IngredienteId)
            .HasConstraintName("FK_ItemPedidoRemocoes_Ingredientes")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
