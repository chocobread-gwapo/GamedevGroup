using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;

public class starttrigger : MonoBehaviour
{
    private void OnTriggerEnter()
    {

        //to restart our same scenes..when we exit in enter direction 
        //it will restart the same scene when we get out in start position
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

}
