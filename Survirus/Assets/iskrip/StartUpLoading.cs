using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class StartUpLoading : MonoBehaviour
{
    [SerializeField]
    private Image progressBar;

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(LoadAsyncOperation());
    }

    IEnumerator LoadAsyncOperation()
    {
        AsyncOperation nextScene = SceneManager.LoadSceneAsync("StartMenu");

        while (nextScene.progress < 1)
        {
            progressBar.fillAmount = nextScene.progress;
            yield return new WaitForEndOfFrame();
        }
    }
}
