
// точность используемая в качестве стандартной (если аргумент не был передан)
/*
	В данном случаи, точность это предел поиска
	(например при точности 32, мы остановим поиск, когда найденная скорость, будет меньше 32)
*/
#macro MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY	0.8

//					check = check(speed, data)
/// @function		magCollsJump(speed, check, [data], [accuracy]);
/// @description	Вернёт true, при наличии столкновения, а так же запишет в
//					global.magCollsDist "свободную" скорость
//					(под свободной я подразумеваю, скорость при которой столкновения нету)
//					Для поиска мы используем, что-то вроде бинарного поиска
//					(Это может быть намного эффективнее чем magCollsMove_single и magCollsMove_double)
function magCollsJump(_speed, _check, _data, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	if (_check(_speed, _data)) {
		
		_speed /= 2;
		var _mathSpeed = _speed;
		
		while (_speed > _accuracy) {
			
			_speed /= 2;
			if (_check(_mathSpeed, _data))
				_mathSpeed -= _speed;
			else
				_mathSpeed += _speed;
		}
		
		global.magCollsDist = _mathSpeed;
		return true;
	}
	
	global.magCollsDist = _speed;
	return false;
}

