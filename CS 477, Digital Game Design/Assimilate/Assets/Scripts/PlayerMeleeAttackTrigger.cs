using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMeleeAttackTrigger : MonoBehaviour {

    public int damage = 5;

    void OnTriggerEnter2D(Collider2D col)
    {
        if(col.isTrigger != true && (col.CompareTag("EnemyMech") || col.CompareTag("BossMinion") || col.CompareTag("Mage")))
        {
            col.SendMessageUpwards("Damage", damage);
        }
    }

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
