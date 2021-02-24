using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class TimerCountdown : MonoBehaviour
{
    public Slider slider;
    public Text timerText;
    public float gameTime;

    private bool stopTimer;

    void Start()
    {
        stopTimer = false;
        slider.maxValue = gameTime;
        slider.value = gameTime;
    }

    void Update()
    {
        float time = gameTime - Time.time;

        int minutes = Mathf.FloorToInt(time / 60);
        int seconds = Mathf.FloorToInt(time - minutes * 60f);

        string textTime = string.Format("{0:00}:{1:00}", minutes, seconds);

        if (time <= 0)
        {
            stopTimer = true;
        }

        if (stopTimer == false)
        {
            timerText.text = textTime;
            slider.value = time;
        }

        if (timerText.text == "00:00")
        {
            SceneManager.LoadScene("GameOver");
        }
    }
}
