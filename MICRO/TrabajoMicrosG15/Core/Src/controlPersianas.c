#include <controlPersianas.h>

bool persianasArriba=false;
bool persianasAbajo=true;

void subirPersianas()
{
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN1,GPIO_PIN_SET);
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN2,GPIO_PIN_RESET);
	HAL_Delay(3000);
	pararPersianas();
	persianasArriba=true;
	persianasAbajo=false;
}
void bajarPersianas()
{
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN1,GPIO_PIN_RESET);
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN2,GPIO_PIN_SET);
	HAL_Delay(3000);
	pararPersianas();
	persianasArriba=false;
	persianasAbajo=true;
}
void pararPersianas()
{
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN1,GPIO_PIN_RESET);
	HAL_GPIO_WritePin(MOTOR_PORT, MOTOR_PIN2,GPIO_PIN_RESET);
}

