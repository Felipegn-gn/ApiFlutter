namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ClienteConfiguration : IEntityTypeConfiguration<Cliente>
{
    public void Configure(EntityTypeBuilder<Cliente> builder)
    {
        builder.ToTable("Clientes");

        builder.HasKey(c => c.Id)
            .HasName("PK_Clientes");

        builder.Property(c => c.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(c => c.Nome)
            .IsRequired()
            .HasColumnName("Nome")
            .HasMaxLength(255);

        builder.Property(c => c.Telefone)
            .IsRequired()
            .HasColumnName("Telefone")
            .HasMaxLength(20);

        builder.HasIndex(c => c.Telefone)
            .IsUnique()
            .HasDatabaseName("IX_Clientes_Telefone");

        builder.HasMany(c => c.Enderecos)
            .WithOne(e => e.Cliente)
            .HasForeignKey(e => e.ClienteId)
            .HasConstraintName("FK_Enderecos_Clientes")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(c => c.Pedidos)
            .WithOne(p => p.Cliente)
            .HasForeignKey(p => p.ClienteId)
            .HasConstraintName("FK_Pedidos_Clientes")
            .OnDelete(DeleteBehavior.Cascade);
    }
}
