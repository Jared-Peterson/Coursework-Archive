using UnityEngine;

public class PlayerMovement : MonoBehaviour {

    public float jumpForce = 8f;
    public float speed = 6f;
    public Vector3 movement;
    int jumpCount = 0;

    public bool isGrounded;
    Rigidbody2D rb;
    SpriteRenderer mySpriteRenderer;

    // Use this for initialization
    void Start() {
        rb = GetComponent<Rigidbody2D>();
        mySpriteRenderer = GetComponent<SpriteRenderer>();
    }

    private void OnCollisionExit2D(Collision2D collision) {
        if (collision.gameObject.tag == "Ground" || collision.gameObject.tag == "EnemyMech") ;
        {
            isGrounded = false;
        }
        Debug.Log("Leaving 2d " + collision.gameObject.tag);
    }

    private void OnCollisionEnter2D(Collision2D collision) {
        if (collision.gameObject.tag == "Ground" || collision.gameObject.tag == "EnemyMech") {
            isGrounded = true;
            jumpCount = 0;
        }
        Debug.Log("collision jumpCount " + jumpCount);
    }

    // Update is called once per frame
    void Update() {

        float moveHorizontal = Input.GetAxisRaw("Horizontal");

        movement = new Vector2(moveHorizontal, 0);
        movement = movement * speed * Time.deltaTime;
        if (isGrounded) {
            transform.position += movement;
        } else {
            transform.position += movement / 1.5f;
        }


        if ((isGrounded && Input.GetKeyDown("space")) || jumpCount < 2 && Input.GetKeyDown("space")) {
            jumpCount++;
            if (Input.GetKey("d")) {
                rb.velocity = new Vector2(movement.x, jumpForce);

            } else if (Input.GetKey("a")) {
                rb.velocity = new Vector2(-movement.x, jumpForce);

            } else rb.velocity = new Vector2(0, jumpForce);
            Debug.Log("update jumpcount " + jumpCount);
        }


        if (Input.GetKey(KeyCode.A)) {
            //face left
            mySpriteRenderer.flipX = false;
            //set walking animation
            GetComponent<Animator>().SetBool("isWalking", true);

        } else if (Input.GetKey(KeyCode.D)) {
            //face right
            mySpriteRenderer.flipX = true;
            //set walking animation
            GetComponent<Animator>().SetBool("isWalking", true);

        } else {
            //set idle animation
            GetComponent<Animator>().SetBool("isWalking", false);
        }

        if (Input.GetKey(KeyCode.Mouse0)) {
            //left mouse button is pressed play attack animation
            GetComponent<Animator>().SetTrigger("attack");
        }
    }
}
