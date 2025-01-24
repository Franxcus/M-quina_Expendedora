
#ifndef INC_CONTROLPERSIANAS_H_
#define INC_CONTROLPERSIANAS_H_

#include "stm32f4xx_hal.h"
#include <stdbool.h>

// Definiciones de pines y periféricos para los servos
//#define MOTOR_TIM_HANDLE htim2
#define MOTOR_PORT GPIOD
#define MOTOR_PIN1 GPIO_PIN_9
#define MOTOR_PIN2 GPIO_PIN_8

extern bool persianasArriba;
extern bool persianasAbajo;

void subirPersianas();
void pararPersianas();
void bajarPersianas();

#endif /* INC_CONTROLPERSIANAS_H_ */
