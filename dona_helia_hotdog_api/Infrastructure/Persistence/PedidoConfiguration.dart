namespace Infrastructure.Persistence;

using Domain.Entities;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class PedidoConfiguration : IEntityTypeConfiguration<Pedido>
{
    public void Configure(EntityTypeBuilder<Pedido> builder)
    {
        builder.ToTable("Pedidos");

        builder.HasKey(p => p.Id)
            .HasName("PK_Pedidos");

        builder.Property(p => p.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(p => p.ClienteId)
            .IsRequired()
            .HasColumnName("ClienteId");

        builder.Property(p => p.EnderecoEntregaId)
            .IsRequired()
            .HasColumnName("EnderecoEntregaId");

        builder.Property(p => p.ValorTotal)
            .IsRequired()
            .HasColumnName("ValorTotal")
            .HasColumnType("decimal(10,2)");

        builder.Property(p => p.FormaPagamento)
            .IsRequired()
            .HasColumnName("FormaPagamento")
            .HasColumnType("int")
            .HasConversion<int>();

        builder.Property(p => p.Status)
            .IsRequired()
            .HasColumnName("Status")
            .HasColumnType("int")
            .HasConversion<int>()
            .HasDefaultValue(StatusPedido.Pendente);

        builder.Property(p => p.ObservacaoGeral)
            .HasColumnName("ObservacaoGeral")
            .HasMaxLength(500);

        builder.Property(p => p.DataCriacao)
            .IsRequired()
            .HasColumnName("DataCriacao")
            .HasDefaultValueSql("CURRENT_TIMESTAMP");

        builder.HasOne(p => p.Cliente)
            .WithMany(c => c.Pedidos)
            .HasForeignKey(p => p.ClienteId)
            .HasConstraintName("FK_Pedidos_Clientes")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(p => p.EnderecoEntrega)
            .WithMany(e => e.Pedidos)
            .HasForeignKey(p => p.EnderecoEntregaId)
            .HasConstraintName("FK_Pedidos_Enderecos")
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasMany(p => p.ItensPedido)
            .WithOne(ip => ip.Pedido)
            .HasForeignKey(ip => ip.PedidoId)
            .HasConstraintName("FK_ItensPedido_Pedidos")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
