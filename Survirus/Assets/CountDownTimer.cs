using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CountDownTimer : MonoBehaviour
{
    [SerializeField] float startTime = 5f;
    [SerializeField] Slider slider1;
    [SerializeField] TextMeshProUGUI timerText1;

    float timer1 = 0f;

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(Timer1());
    }

    private IEnumerator Timer1()
    {
        float timer1 = startTime;

        do
        {
            timer1 -= Time.deltaTime;
            slider1.value = timer1 / startTime;
            FormatText1();
            yield return null;
        }
        while (timer1 > 0);
    }

    private void FormatText1()
    {
        int days = (int)(timer1 / 86400) % 365;
        int hours = (int)(timer1 / 3600) % 24;
        int minutes = (int)(timer1 / 60) % 60;
        int seconds = (int)(timer1 / 60);

        timerText1.text = "";
        if (days > 0) { timerText1.text += days + "d "; }
        if (hours > 0) { timerText1.text += hours + "h "; }
        if (minutes > 0) { timerText1.text += minutes + "m "; }
        if (seconds > 0) { timerText1.text += seconds + "s "; }
    }
}


