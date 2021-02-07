using UnityEngine;
using UnityEngine.SceneManagement;

public class levelhandler : MonoBehaviour
{
    // Start is called before the first frame update
    
    public void level1()
    {
        SceneManager.LoadScene("level1");
    }

    public void exit()
    {
        SceneManager.LoadScene("menu");
    }      

    
}
