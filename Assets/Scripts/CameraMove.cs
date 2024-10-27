using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Transform target; // Цель, вокруг которой будет вращаться камера
    public float rotationSpeed = 5f; // Скорость вращения камеры

    private void Update()
    {
        // Проверка, что цель существует
        if (target == null)
        {
            Debug.LogWarning("Не установлена цель для камеры!");
            return;
        }

        // Вращение камеры вокруг цели
        transform.RotateAround(target.position, Vector3.up, rotationSpeed * Time.deltaTime);
    }
}
