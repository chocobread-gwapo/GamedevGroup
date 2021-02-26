using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.SceneManagement;

public class Credits : MonoBehaviour
{
    public double time;
    public double currentTime;

    void Start()
    {
        StartCoroutine(WaitSeconds());
        time = gameObject.GetComponent<VideoPlayer>().clip.length - 0.04;
    }

    void Update()
    {
        currentTime = gameObject.GetComponent<VideoPlayer>().time;

        if (currentTime == time)
        {
            StartCoroutine(WaitSeconds());
            SceneManager.LoadScene("StartMenu");
        }
    }

    IEnumerator WaitSeconds()
    {
        yield return new WaitForSeconds(5);
    }
}
