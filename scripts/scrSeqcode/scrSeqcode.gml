
enum SEQCODE_SEQARRKEY {METHOD, NAME};

function Seqcode() constructor {
	
	#region __private
			     
	self.__seq   = [];
	self.__idn   = 0;
	self.__names = {};
	self.__size  = 0;
	
	static __newName = function(_name, _errorAdd) {
		
		if (is_undefined(_name)) {
			
			_name = "_" + string(self.__idn);
		}
		
		if (variable_struct_exists(self.__names, _name)) {
			
			show_error("Имя: <" + _name + "> уже занято (" + _errorAdd + ")", true);
		}
		
		++self.__idn;
		return _name;
	}
	
	static __find = function(_name) {
		
		var _size = self.__size;
		while (_size > 0) {
			
			--_size;
			if (self.__seq[_size][SEQCODE_SEQARRKEY.NAME] == _name)
				return _size;
		}
		return -1;
	}
	
	#endregion
	
	static add = function(_f, _name) {
		
		_name = self.__newName(_name, "SeqcodeBuild.add");
		
		var _cell = [
			_f,
			_name,
		];
		
		self.__names[$ _name] = _cell;
		array_push(self.__seq, _cell);
		
		++self.__size;
		return _name;
	}
	
	static insert = function(_nameIndex, _offset, _f, _name) {
		
		if (variable_struct_exists(self.__names, _nameIndex)) {
			
			_name = self.__newName(_name, "SeqcodeBuild.insert");
			
			var _cell = [
				_f,
				_name,
			];
			
			self.__names[$ _name] = _cell;
			array_insert(
				self.__seq, 
				clamp(self.__find(_nameIndex) + _offset, 0, self.__size),
				_cell
			);
			
			++self.__size;
			return _name;
		}
		
		show_error("Имя: <" + _nameIndex + "> не существует (SeqcodeBuild.insert)", true);
	}
	
	static remove = function(_name) {
		
		if (variable_struct_exists(self.__names, _name)) {
			
			variable_struct_remove(self.__names, _name);
			array_delete(self.__seq, self.__find(_name), 1);
			
			--self.__size;
			return true;
		}
		return false;
	}
	
	static build = function() {
		
		if (self.__size < 0) {
			
			show_error("Пустой seqcode недопустим <SeqcodeBuild.build>", true);
		}
		
		var _size  = self.__size;
		var _array = array_create(_size);
		
		while (_size > 0) {
			
			--_size;
			_array[_size] = self.__seq[_size][SEQCODE_SEQARRKEY.METHOD];
		}
		return new __Seqcode(_array);
	}
	
	static getPrev = function(_name) {
		
		if (variable_struct_exists(self.__names, _name)) {
			
			var _index = self.__find(_name) - 1;
			if (_index > -1) 
				return self.__seq[_index][SEQCODE_SEQARRKEY.NAME];
		}
	}
	
	static getNext = function(_name) {
		
		if (variable_struct_exists(self.__names, _name)) {
			
			var _index = self.__find(_name);
			if (_index != -1) {
				
				++_index;
				if (_index < self.__size) 
					return self.__seq[_index][SEQCODE_SEQARRKEY.NAME];
			}
		}
	}
	
	static getSize = function() {
		
		return self.__size;
	}
	
	static toString = function() {
		
		return "seqBuild [..." + string(self.__size) + " events]";
	}
	
}

function __Seqcode(_seq) constructor {
	
	#region __private
	
	self.__seq  = _seq;
	self.__size = array_length(_seq);
	
	#endregion
	
	static tick = function(_data) {
		
		for (var _i = 0; _i < self.__size; ++_i) {
			
			self.__seq[_i](_data);
		}
	}
	
	static getTick = function() {
		
		return method(self, self.tick);
	}
	
	static getSize = function() {
		
		return self.__size;
	}
	
	static toString = function() {
		
		return "seq [..." + string(self.__size) + " events]";
	}
	
}

