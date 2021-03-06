/* arch-tag: Python Utility Functions
Copyright (C) 2005 John Goerzen <jgoerzen@complete.org>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <Python.h>

void hspy_decref(PyObject *o) {
  Py_DECREF(o);
}

void hspy_incref(PyObject *o) {
  Py_INCREF(o);
}

int hspy_list_check(PyObject *o) {
  return PyList_Check(o);
}

int hspy_tuple_check(PyObject *o) {
  return PyTuple_Check(o);
}

PyObject ** hspy_getexc(void) {
  static PyObject *retval [3];
  PyObject *type;
  PyObject *val;
  PyObject *tb;

  PyErr_Fetch(&type, &val, &tb);
  PyErr_NormalizeException(&type, &val, &tb);
  retval[0] = type;
  retval[1] = val;
  retval[2] = tb;
  PyErr_Clear();
  return retval;
}

PyObject *hspy_none(void) {
  Py_INCREF(Py_None);
  return Py_None;
}

PyObject *glue_PyMapping_Keys(PyObject *o) {
  return PyMapping_Keys(o);
}

PyObject *glue_PyMapping_Items(PyObject *o) {
  return PyMapping_Items(o);
}
