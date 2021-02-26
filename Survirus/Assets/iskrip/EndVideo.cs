using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.SceneManagement;

public class EndVideo : MonoBehaviour
{
    public double time;
    public double currentTime;

    void Start()
    {
        StartCoroutine(WaitSeconds());
        time = gameObject.GetComponent<VideoPlayer>().clip.length;
    }

    void Update()
    {
        currentTime = gameObject.GetComponent<VideoPlayer>().time;

        if (currentTime == time)
        {
            StartCoroutine(WaitSeconds());
            SceneManager.LoadScene("Credits");
        }
    }

    IEnumerator WaitSeconds()
    {
        yield return new WaitForSeconds(5);
    }
}
