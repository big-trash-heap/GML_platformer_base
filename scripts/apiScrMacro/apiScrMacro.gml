
								// Удобный и очень важный синоним
#macro _						undefined

								// Упаковщик аргументов в массив
#macro API_MACRO_ARGPACK_OFFS   var __argOffs =
#macro API_MACRO_ARGPACK_READ	var __argSize = argument_count;							\
								var __argArrs = array_create(__argSize - __argOffs);	\
								for (var __i = __argOffs; __i < __argSize; ++__i)		\
									__argArrs[__i - __argOffs] = argument[__i];                                          

#macro API_MACRO_ARGPACK_GET	__argArrs

								//
#macro API_MACRO_UINT16_MAX		65535
#macro API_MACRO_INT32_MAX		2147483647
#macro API_MACRO_INT32_MIN		(-2147483648)
								
								//
#macro API_MACRO_DEFCHAR		"▯"

