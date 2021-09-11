
								// Объект от которого наследуются все столкновения
								// (Он всегда один)
#macro PH_COLLS_OBJECT			objCollsObj

global.__ph_list = ds_list_create(); // Используется для проверки столкновений

//
enum PH_TYPE {SOLID, SOFT};
