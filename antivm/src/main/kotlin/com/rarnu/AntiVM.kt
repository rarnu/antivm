package com.rarnu

import android.os.Build

object AntiVM {
    init {
        try {
            System.loadLibrary("antivm")
        } catch (t: Throwable) {

        }
    }

    external fun init()
    external fun isEmulator(): Boolean
    external fun isHooked(): Boolean
    external fun isInVM(): Boolean
    external fun isRooted(): Boolean

}