using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class TimerCountdown : MonoBehaviour
{

    public GameObject textDisplay;
    public int secondsLeft = 30;
    public bool takingAway = false;

    private void Start()
    {
        textDisplay.GetComponent<Text>().text = "00:"+ secondsLeft;
    }

    void Update()
    {
        if (takingAway == false && secondsLeft > 0)
        {
            StartCoroutine(TimerTake());
        }
        else if (secondsLeft ==  0)
        {
            SceneManager.LoadScene("GameOver");
        }
    }



    IEnumerator TimerTake()
    {
        takingAway = true;
        yield return new WaitForSeconds(1);
        secondsLeft -= 1;
        textDisplay.GetComponent<Text>().text = "00:"+ secondsLeft;
        takingAway = false;
    }
}
