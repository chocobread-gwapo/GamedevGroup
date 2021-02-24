using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class lvlAudio : MonoBehaviour
{
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private static lvlAudio instance = null;
    public static lvlAudio Instance
    {
        get { return instance; }
    }
    
    void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(this.gameObject);
            return;
        }
        else
        {
            DontDestroyOnLoad(this.gameObject);
        }
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
