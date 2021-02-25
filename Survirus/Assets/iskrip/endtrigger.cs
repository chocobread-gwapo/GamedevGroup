//dont forget to include this 
using UnityEngine.SceneManagement;
using System.Collections;
using UnityEngine;

public class endtrigger : MonoBehaviour
{
    private void OnTriggerEnter()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }
}
