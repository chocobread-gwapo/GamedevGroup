using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class HealthbarController : MonoBehaviour
{
    public Image healthBar;
    public float health;
    public float startHealth;

    public void OnTakeDamage(int damage)
    {
        health = health - damage;
        healthBar.fillAmount = health / startHealth;
    }

    void Update()
    {
        if (health == 0)
        {
            SceneManager.LoadScene("GameOver");
        }
    }

}