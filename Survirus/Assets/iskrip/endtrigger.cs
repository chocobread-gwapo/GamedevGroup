//dont forget to include this 
using UnityEngine.SceneManagement;
using System.Collections;
using UnityEngine;

public class endtrigger : MonoBehaviour
{
    private void OnTriggerEnter()
    {
        //to start our upcoming scenes..
	//this is to control our scene order by we add in build settings

        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1); 
    }
}
