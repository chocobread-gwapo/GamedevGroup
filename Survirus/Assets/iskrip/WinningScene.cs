using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class WinningScene : MonoBehaviour
{
    private void OnTriggerEnter()
    {
        SceneManager.LoadScene("WinningScene");
    }
}
