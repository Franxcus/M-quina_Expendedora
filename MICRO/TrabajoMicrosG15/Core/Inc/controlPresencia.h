
#ifndef INC_CONTROLPRESENCIA_H_
#define INC_CONTROLPRESENCIA_H_

#include "stm32f4xx_hal.h"

#define TIM_CHANNEL TIM_CHANNEL_1

extern uint32_t valor1;
extern uint32_t valor2;
extern uint32_t diferencia;
extern uint8_t primerEvento;
extern uint8_t distancia;

void controlPresencia(TIM_HandleTypeDef *htim);

#endif /* INC_CONTROLPRESENCIA_H_ */
