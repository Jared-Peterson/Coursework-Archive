using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;



public class PlayerAttacks : MonoBehaviour
{

    public Slider heatbar; //for ui
    public int heat;
    Rigidbody2D player;

    //for melee attacks
    private bool attacking = false;
    private float attackTimer = 0;
    private float attackCoolDown = 0.3f;
    public Collider2D attackTrigger;
    private Animator anim;

    [Header("Laser pieces")]
    public GameObject laserStart;
    public GameObject laserMiddle;
    public GameObject laserEnd;

    private GameObject start;
    private GameObject middle;
    private GameObject end;

    private bool grenadeCooldown;
    private float heatTimer;
    private float grenadeTimer;
    private float heatReduceTimer;

    // Use this for initialization
    void Start()
    {
        heat = 0;
        player = GetComponent<Rigidbody2D>();
        heatTimer = 0;
        grenadeCooldown = true;
        grenadeTimer = 0;

        anim = gameObject.GetComponent<Animator>();
        attackTrigger.enabled = false;

    }

    void Update()
    {

        heatbar.value = heat;
        heatReduceTimer += Time.deltaTime;

        //for melee attacks
        if (Input.GetMouseButtonDown(0) && !attacking) {
            attacking = true;
            attackTimer = attackCoolDown;
            attackTrigger.enabled = true;
        }

        if (attacking) {
            if (attackTimer > 0) {
                attackTimer -= Time.deltaTime;
            } else {
                attacking = false;
                attackTrigger.enabled = false;
            }
        }

        anim.SetBool("attack", attacking);

        if (heatReduceTimer > 4) {
            if (heat > 10) {
                heat -= 10;
            } else {
                heat = 0;
            }
            heatReduceTimer = 0;
        }

        if (Input.GetKey(KeyCode.Mouse1) && heat < 100) {
            // Create the laser start from the prefab
            heatTimer += Time.deltaTime;

            if (heatTimer > .1) {
                heat += 2;
                heatTimer = 0;
            }

            //Laser start
            if (start == null) {
                start = Instantiate(laserStart) as GameObject;
                start.transform.parent = this.transform;
                start.transform.localPosition = Vector2.zero;
            }

            // Laser middle
            if (middle == null) {
                middle = Instantiate(laserMiddle) as GameObject;
                middle.transform.parent = this.transform;
                middle.transform.localPosition = Vector2.zero;
            }

            // Define an "infinite" size, not too big but enough to go off screen
            float maxLaserSize = 10f;
            float currentLaserSize = maxLaserSize;

            Vector2 laserDirection = this.transform.right;
            RaycastHit2D hit = Physics2D.Raycast(this.transform.position, laserDirection, maxLaserSize);

            if (hit.collider != null) {
                // We touched something!

                // -- Get the laser length
                currentLaserSize = Vector2.Distance(hit.point, this.transform.position);

                // -- Create the end sprite
                if (end == null) {
                    end = Instantiate(laserEnd) as GameObject;
                    end.transform.parent = this.transform;
                    end.transform.localPosition = Vector2.zero;
                }
            } else {
                // Nothing hit
                // -- No more end
                if (end != null) Destroy(end);
            }

            // Place things
            // -- Gather some data
            float startSpriteWidth = start.GetComponent<Renderer>().bounds.size.x;
            float endSpriteWidth = 0f;
            if (end != null) endSpriteWidth = end.GetComponent<Renderer>().bounds.size.x;

            // -- the middle is after start and, as it has a center pivot, have a size of half the laser (minus start and end)
            middle.transform.localScale = new Vector3(currentLaserSize - startSpriteWidth, middle.transform.localScale.y, middle.transform.localScale.z);
            middle.transform.localPosition = new Vector2((currentLaserSize / 2f), 0f);

            // End?
            if (end != null) {
                end.transform.localPosition = new Vector2(currentLaserSize, 0f);
            }
        }//end button click
        else if (Input.GetMouseButtonUp(1) || heat == 100) {
            DestroyImmediate(start);
            DestroyImmediate(middle);
            DestroyImmediate(end);
        }

        if (Input.GetKeyDown(KeyCode.E) && grenadeCooldown) {
            if (heat > 50)
                heat -= 50;
            else
                heat = 0;
            grenadeCooldown = false;
            grenadeTimer = 0;

            //code for blue ring goes here

        }

        if (!grenadeCooldown)
            if (grenadeTimer > 10) {
                grenadeCooldown = true;
            } else {
                grenadeTimer += Time.deltaTime;
            }
    }
}
