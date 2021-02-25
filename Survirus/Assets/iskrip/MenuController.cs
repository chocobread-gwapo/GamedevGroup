using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.Audio;

public class MenuController : MonoBehaviour
{
    // Start is called before the first frame update
    public AudioMixer audioMixer;
    public Dropdown resolutionDropdown;
    //public static bool Game_Is_Paused = false;

    Resolution[] resolutions;

    void Start()
    {
        resolutions = Screen.resolutions;

        resolutionDropdown.ClearOptions();

        List<string> options = new List<string>();

        int currentResolutionIndex = 0;
        for (int i=0; i<resolutions.Length; i++)
        {
            string option = resolutions[i].width + " x " + resolutions[i].height;
            options.Add(option);

            if (resolutions[i].width == Screen.currentResolution.width &&
                resolutions[i].height == Screen.currentResolution.height)
            {
                currentResolutionIndex = i;
            }
        }

        resolutionDropdown.AddOptions(options);
        resolutionDropdown.value = currentResolutionIndex;
        resolutionDropdown.RefreshShownValue();

    }

    // Update is called once per frame
    void Update()
    {
        /*if (Input.GetKeyDown(KeyCode.Escape))
        {
            Resume();
        }
        else
        {
            Pause();
        }*/
    }
    public GameObject settingsMenuHolder;
    public GameObject mainMenuHolder;
    //public GameObject pauseMenuHolder;

    public Slider[] volumeSliders;

    public void StartGame()
    {
        SceneManager.LoadScene("Level 1");
    }

    public void Restart()
    {
        SceneManager.LoadScene("Level 1");
    }

    public void StartMenu()
    {
        SceneManager.LoadScene("StartMenu");
    }

    public void QuitGame()
    {
        Application.Quit();
        Debug.Log("Quit!");
    }

    public void SettingsMenu()
    {
        settingsMenuHolder.SetActive(true);
        mainMenuHolder.SetActive(false);
        //pauseMenuHolder.SetActive(false);
    }

    public void MainMenu()
    {
        mainMenuHolder.SetActive(true);
        settingsMenuHolder.SetActive(false);
        //pauseMenuHolder.SetActive(false);
    }

    /*public void Pause_Menu()
    {
        mainMenuHolder.SetActive(false);
        settingsMenuHolder.SetActive(false);
        pauseMenuHolder.SetActive(true); 
    }

    public void Resume()
    {
        //pauseMenuUI.SetActive(false);
        pauseMenuHolder.SetActive(false);
        Time.timeScale = 1f;
        Game_Is_Paused = false;
    }

    void Pause()
    {
        //pauseMenuUI.SetActive(true);
        pauseMenuHolder.SetActive(true);
        Time.timeScale = 0f;
        Game_Is_Paused = true;
    }*/

    public void SetResolution (int resolutionIndex)
    {
        Resolution resolution = resolutions[resolutionIndex];
        Screen.SetResolution(resolution.width, resolution.height, Screen.fullScreenMode);
    }
    public void SetFullscreen(bool fullscreen)
    {
        Screen.fullScreen = fullscreen;
        if (Screen.fullScreen)
        {
            Screen.fullScreenMode = FullScreenMode.ExclusiveFullScreen;
        }
        else
        {
            Screen.fullScreenMode = FullScreenMode.Windowed;
        }
    }

    public void SetVolume(float volume)
    {
        audioMixer.SetFloat("Volume", volume);
    }

}

