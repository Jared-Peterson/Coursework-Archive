using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyFollow : MonoBehaviour {

    public float speed;
    public float stoppingDistance;
    private bool followPlayer = false;
    private Transform target;

    // Use this for initialization
    void Start() {
        target = GameObject.FindGameObjectWithTag("Player").GetComponent<Transform>();
    }

    // Update is called once per frame
    void Update() {
        if (Vector2.Distance(transform.position, target.position) > stoppingDistance && followPlayer) {
            if (target.position.x > transform.position.x) {
                //face right
                transform.localScale = new Vector3(2, transform.localScale.y, transform.localScale.z);
            } else if (target.position.x < transform.position.x) {
                //face left
                transform.localScale = new Vector3(-2, transform.localScale.y, transform.localScale.z);
            }
            transform.position = Vector2.MoveTowards(transform.position, target.position, speed * Time.deltaTime);
        }

    }

    public void Flip() {
        transform.localScale = new Vector3(-transform.localScale.x, transform.localScale.y, transform.localScale.z);
    }
    private void OnTriggerEnter2D(Collider2D collision) {
        if (collision.gameObject.tag == "Player") {
            followPlayer = true;
            Debug.Log("Follow Player is true");
        }
    }
    private void OnTriggerExit2D(Collider2D collision) {
        if (collision.gameObject.tag == "Player") {
            followPlayer = false;
            Debug.Log("Follow Player is false");
        }
    }

}
