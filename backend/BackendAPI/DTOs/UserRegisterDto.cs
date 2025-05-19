using System.ComponentModel.DataAnnotations;

namespace BackendAPI.DTOs;

public class UserRegisterDto
{
    [Required]
    public string Name { get; set; }

    [Required]
    [EmailAddress]
    public string Email { get; set; }

    [Required]
    [MinLength(6)]
    public string Password { get; set; }
}