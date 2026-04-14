namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ItemPedidoAdicionalConfiguration : IEntityTypeConfiguration<ItemPedidoAdicional>
{
    public void Configure(EntityTypeBuilder<ItemPedidoAdicional> builder)
    {
        builder.ToTable("ItemPedidoAdicional");

        builder.HasKey(ipa => ipa.Id)
            .HasName("PK_ItemPedidoAdicional");

        builder.Property(ipa => ipa.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(ipa => ipa.ItemPedidoId)
            .IsRequired()
            .HasColumnName("ItemPedidoId");

        builder.Property(ipa => ipa.AdicionalId)
            .IsRequired()
            .HasColumnName("AdicionalId");

        builder.Property(ipa => ipa.Quantidade)
            .IsRequired()
            .HasColumnName("Quantidade")
            .HasColumnType("int");

        builder.Property(ipa => ipa.PrecoUnitarioAdicional)
            .IsRequired()
            .HasColumnName("PrecoUnitarioAdicional")
            .HasColumnType("decimal(10,2)");

        builder.HasOne(ipa => ipa.ItemPedido)
            .WithMany(ip => ip.Adicionais)
            .HasForeignKey(ipa => ipa.ItemPedidoId)
            .HasConstraintName("FK_ItemPedidoAdicional_ItensPedido")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ipa => ipa.Adicional)
            .WithMany(a => a.ItensPedidoAdicional)
            .HasForeignKey(ipa => ipa.AdicionalId)
            .HasConstraintName("FK_ItemPedidoAdicional_Adicionais")
            .OnDelete(DeleteBehavior.Restrict);
    }
}
