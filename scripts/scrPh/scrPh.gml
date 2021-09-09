
								// Объект от которого наследуются все столкновения
								// (Он всегда один)
#macro PH_COLLS_OBJECT			objCollsObj

global.__ph_list = ds_list_create(); // Используется для проверки столкновений

/* эти значение должны быть положительными (это не проверяется) */
global.phGravityMax = infinity;		 // Максимальное ускорение вниз
global.phGravityAcl = 1;			 // Ускорение за 1 шаг (линейное)

function phGravitySet(_max, _acl) {
	
	if (!is_undefined(_max)) {
		global.phGravityMax = _max;
	}
	
	if (!is_undefined(_acl)) {
		global.phGravityAcl = _acl;
	}
}

function phGravityAdd(_max, _acl) {
	
	if (!is_undefined(_max)) {
		global.phGravityMax += _max;
	}
	
	if (!is_undefined(_acl)) {
		global.phGravityAcl += _acl;
	}
}


debug {
	show_debug_message(@"
	Print scrPhInit:
		Data:
		global.__ph_list      : " + string(global.__ph_list) + @"
		
		global.phGravityMax   : " + string(global.phGravityMax) + @"
		global.phGravityAcl   : " + string(global.phGravityAcl) + @"
");
}

