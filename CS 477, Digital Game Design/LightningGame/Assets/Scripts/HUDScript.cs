using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HUDScript : MonoBehaviour {

	float playerScore = 0;

	void Update() {
		playerScore += Time.deltaTime;
	}

	public void IncreaseScore(int amount){
		playerScore += amount;
	}

	void OnDisable(){
		PlayerPrefs.SetInt("Score", (int)(playerScore * 10));
	}

	void OnGUI(){
		GUI.Label(new Rect(10,10,100,30), "Score: " + (int)(playerScore * 10));
	}
}
