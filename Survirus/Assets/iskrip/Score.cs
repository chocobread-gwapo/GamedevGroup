using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
    public Text scoreText;
    public float scoreAmount;
    public float pointDecreasedPerSecond;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        scoreText.text = scoreAmount.ToString("0");
        scoreAmount -= pointDecreasedPerSecond * Time.deltaTime;
    }
}
