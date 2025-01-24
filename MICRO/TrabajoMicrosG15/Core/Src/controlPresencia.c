#include "controlPresencia.h"

uint32_t valor1 = 0;
uint32_t valor2 = 0;
uint32_t diferencia = 0;
uint8_t primerEvento = 0;
uint8_t distancia  = 0;

void controlPresencia(TIM_HandleTypeDef *htim)
{
	if (primerEvento==0) //Si no hemos detectado nada todavía, leemos el valor del IC como referencia de tiempo
			{
				valor1 = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL);
				primerEvento = 1;
				// Cambiamos la polaridad de el modo de captura, para recoger el valor de tiempo en la caída del pulso
				__HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL, TIM_INPUTCHANNELPOLARITY_FALLING);
			}

			else if (primerEvento==1)   // Si ya hemos capturado el primer valor, capturamos el segundo y realizamos el calculo de tiempo.
			{
				valor2 = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL);
				__HAL_TIM_SET_COUNTER(htim, 0);  // Reseteo del counter para la próxima medida

				if (valor2 > valor1)
				{
					diferencia = valor2-valor1;
				}
				//En caso de pasarse del period del TIM, valor 1 será mayor que valor 2, por lo que habrá que restarle el valor1 al periodo.
				else if (valor1 > valor2)
				{
					diferencia = (2000 - valor1) + valor2;
				}

				distancia = diferencia * .034/2; // Distancia en centrimetros
				primerEvento = 0; // Lo reseteamos para la próxima

				// Volvemos a ponerlo en rising_mode para detección del flanco de subida del próximo pulso
				__HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL, TIM_INPUTCHANNELPOLARITY_RISING);

			}
}
