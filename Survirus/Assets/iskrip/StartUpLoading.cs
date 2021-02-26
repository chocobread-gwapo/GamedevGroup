using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class StartUpLoading : MonoBehaviour
{
    public GameObject loadingScreenObj;

    AsyncOperation async;

    public void Start()
    {
        StartCoroutine(loadingScreen());
    }

    IEnumerator loadingScreen()
    {
        loadingScreenObj.SetActive(true);
        async = SceneManager.LoadSceneAsync("StartMenu");
        async.allowSceneActivation = false;

        while (async.isDone == false)
        {

            if (async.progress == 0.9f)
            {
                async.allowSceneActivation = true;
            }

            yield return null;
        }
    }
}
