namespace Infrastructure.Persistence;

using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class EnderecoConfiguration : IEntityTypeConfiguration<Endereco>
{
    public void Configure(EntityTypeBuilder<Endereco> builder)
    {
        builder.ToTable("Enderecos");

        builder.HasKey(e => e.Id)
            .HasName("PK_Enderecos");

        builder.Property(e => e.Id)
            .HasColumnName("Id")
            .ValueGeneratedNever();

        builder.Property(e => e.ClienteId)
            .IsRequired()
            .HasColumnName("ClienteId");

        builder.Property(e => e.Logradouro)
            .IsRequired()
            .HasColumnName("Logradouro")
            .HasMaxLength(255);

        builder.Property(e => e.Numero)
            .IsRequired()
            .HasColumnName("Numero")
            .HasMaxLength(20);

        builder.Property(e => e.Bairro)
            .IsRequired()
            .HasColumnName("Bairro")
            .HasMaxLength(100);

        builder.Property(e => e.Complemento)
            .HasColumnName("Complemento")
            .HasMaxLength(255);

        builder.HasOne(e => e.Cliente)
            .WithMany(c => c.Enderecos)
            .HasForeignKey(e => e.ClienteId)
            .HasConstraintName("FK_Enderecos_Clientes")
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(e => e.Pedidos)
            .WithOne(p => p.EnderecoEntrega)
            .HasForeignKey(p => p.EnderecoEntregaId)
            .HasConstraintName("FK_Pedidos_Enderecos")
            .OnDelete(DeleteBehavior.Restrict);
    }
}
