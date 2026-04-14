namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ItemPedidoConfiguration : IEntityTypeConfiguration<ItemPedido>
{
    public void Configure(EntityTypeBuilder<ItemPedido> builder)
    {
        builder.ToTable("ItensPedido");

        builder.HasKey(ip => ip.Id)
            .HasName("PK_ItensPedido");

        builder.Property(ip => ip.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(ip => ip.PedidoId)
            .IsRequired()
            .HasColumnName("PedidoId");

        builder.Property(ip => ip.ProdutoId)
            .IsRequired()
            .HasColumnName("ProdutoId");

        builder.Property(ip => ip.Quantidade)
            .IsRequired()
            .HasColumnName("Quantidade")
            .HasColumnType("int");

        builder.Property(ip => ip.PrecoUnitarioCalculado)
            .IsRequired()
            .HasColumnName("PrecoUnitarioCalculado")
            .HasColumnType("decimal(10,2)");

        builder.Property(ip => ip.ObservacaoItem)
            .HasColumnName("ObservacaoItem")
            .HasMaxLength(255);

        builder.HasOne(ip => ip.Pedido)
            .WithMany(p => p.ItensPedido)
            .HasForeignKey(ip => ip.PedidoId)
            .HasConstraintName("FK_ItensPedido_Pedidos")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ip => ip.Produto)
            .WithMany(pr => pr.ItensPedido)
            .HasForeignKey(ip => ip.ProdutoId)
            .HasConstraintName("FK_ItensPedido_Produtos")
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasMany(ip => ip.Remocoes)
            .WithOne(ipr => ipr.ItemPedido)
            .HasForeignKey(ipr => ipr.ItemPedidoId)
            .HasConstraintName("FK_ItemPedidoRemocoes_ItensPedido")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(ip => ip.Adicionais)
            .WithOne(ipa => ipa.ItemPedido)
            .HasForeignKey(ipa => ipa.ItemPedidoId)
            .HasConstraintName("FK_ItemPedidoAdicional_ItensPedido")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
