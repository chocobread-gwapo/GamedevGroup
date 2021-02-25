using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class VideoTimerOne : MonoBehaviour
{
    public int secondsLeft = 30;
    public bool takingAway = false;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (takingAway == false && secondsLeft > 0)
        {
            StartCoroutine(TimerTake());
        }

        if (secondsLeft == 0)
        {
            SceneManager.LoadScene("StartUpLoading");
        }
    }

    IEnumerator TimerTake()
    {
        takingAway = true;
        yield return new WaitForSeconds(1);
        secondsLeft -= 1;
        if (secondsLeft >= 60)
        {
            takingAway = false;

        }
        else if (secondsLeft < 10)
        {
            int seconds = secondsLeft;
        }
        else
        {
            int seconds = secondsLeft;
        }
        takingAway = false;
    }
}
