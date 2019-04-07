using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHealth : MonoBehaviour {

    public int health;

	// Use this for initialization
	void Start () {
       // health = 20;
	}

    private void OnTriggerEnter2D(Collider2D collision) {
        if (collision.gameObject.tag == "Laser") {
            health -= 5;
        }
        if (health <= 0) {
            Destroy(gameObject);
        }
    }

    // Update is called once per frame
    void Update () {
		
	}

    public void Damage(int damage)
    {
        health -= damage;
    }
}
