package com.rarnu

object AntiVM {
    init {
        try {
            System.loadLibrary("antivm")
        } catch (t: Throwable) {

        }
    }
    external fun isEmulator(): Boolean
    external fun isHooked(): Boolean
    external fun isInVM(): Boolean
    external fun isRooted(): Boolean

}