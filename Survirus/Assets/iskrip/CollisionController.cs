using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionController : MonoBehaviour
{
    public HealthbarController healthbar;

    void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "COVID")
        {
            if (healthbar)
            {
                healthbar.OnTakeDamage(25);
            }
        }
    }

}
