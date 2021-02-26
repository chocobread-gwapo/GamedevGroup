using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseMenu : MonoBehaviour
{
    public static bool GameIsPaused = false;
    public GameObject pauseMenuUI;
   
    // Update is called once per frame
    public void Update()
    {
        if (Input.GetButtonDown("Cancel"))
        {
            if (GameIsPaused == false)
            {
                Time.timeScale = 0;
                GameIsPaused = true;
                pauseMenuUI.SetActive(true);
            }
            else
            {
                pauseMenuUI.SetActive(false);
                GameIsPaused = false;
                Time.timeScale = 1;
            }
        }
    }

    public void Resume()
    {
        pauseMenuUI.SetActive(false);
        GameIsPaused = false;
        Time.timeScale = 1;
    }

    public void Pause()
    {
        pauseMenuUI.SetActive(true);
        Time.timeScale = 0f;
        GameIsPaused = true;
    }

    public void LoadMenu()
    {
        pauseMenuUI.SetActive(false);
        GameIsPaused = false;
        Time.timeScale = 1;
        SceneManager.LoadScene("StartMenu");
    }

    public void Quit()
    {
        Application.Quit();
        Debug.Log("Quitting game...");
    }

    public void Restart()
    {
        pauseMenuUI.SetActive(false);
        GameIsPaused = false;
        Time.timeScale = 1;
        SceneManager.LoadScene("Level 1"); 
    }
}
    