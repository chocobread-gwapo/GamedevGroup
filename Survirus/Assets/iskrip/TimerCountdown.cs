using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class TimerCountdown : MonoBehaviour
{
    public GameObject textDisplay;
    public Slider slider;
    public int secondsLeft;
    public bool takingAway = false;

    void Start()
    {
        slider.maxValue = secondsLeft;
        slider.value = secondsLeft;

        int minutes = secondsLeft / 60;
        int seconds = secondsLeft - minutes * 60;
        textDisplay.GetComponent<Text>().text = string.Format("{0:00}:{1:00}", minutes, seconds);
    }

    void Update()
    {
        if (takingAway == false && secondsLeft > 0)
        {
            StartCoroutine(TimerTake());
        }

        if (secondsLeft == 0)
        {
            SceneManager.LoadScene("GameOver");
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
            int minutes = Mathf.FloorToInt(secondsLeft / 60);
            int seconds = Mathf.FloorToInt(secondsLeft - minutes * 60);
            textDisplay.GetComponent<Text>().text = string.Format("{0:00}:{1:00}", minutes, seconds);
        }
        else if (secondsLeft < 10)
        {
            int seconds = secondsLeft;
            textDisplay.GetComponent<Text>().text = string.Format("00:0" + seconds);
        }
        else
        {
            int seconds = secondsLeft;
            textDisplay.GetComponent<Text>().text = string.Format("00:" + seconds);
        }
        slider.value = secondsLeft;
        takingAway = false;
    }
}
