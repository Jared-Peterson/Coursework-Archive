using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MinionSpawner : MonoBehaviour {

    public GameObject enemy;
    float nextSpawn = 0.0f;
    Vector2 whereToSpawn;
    public float spawnRate = 5f;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(Time.time > nextSpawn)
        {
            nextSpawn = Time.time + spawnRate;
            whereToSpawn = new Vector2(0, transform.position.y);
            Instantiate(enemy, transform.position, Quaternion.identity);
        }
	}
}
