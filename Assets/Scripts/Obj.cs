using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Obj : MonoBehaviour
{
    public float speed = 2.0f; // Скорость движения объекта
    public float distance = 2.0f; // Расстояние, на которое объект будет двигаться вверх и вниз

    private Vector3 startPos; // Начальная позиция объекта

    void Start()
    {
        startPos = transform.position; // Сохраняем начальную позицию объекта
    }

    void Update()
    {
        // Вычисляем новую позицию объекта
        float newY = startPos.y + Mathf.PingPong(Time.time * speed, distance) - distance / 2.0f;
        transform.position = new Vector3(transform.position.x, newY, transform.position.z);
    }
}