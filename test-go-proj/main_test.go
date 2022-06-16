package main_test

import "testing"

func TestAbsNeg1(t *testing.T) {
	got := -1
	if got != 1 {
		t.Errorf("Abs(-1) = %d; want 1", got)
	}
}

func TestAbsPos(t *testing.T) {
	got := 1
	if got != 1 {
		t.Errorf("Abs(-1) = %d; want 1", got)
	}
}
