package com.rarnu.antivm.sample

import android.app.Activity
import android.os.Bundle
import android.util.Log
import com.rarnu.AntiVM
import kotlinx.android.synthetic.main.activity_main.*
import kotlin.concurrent.thread

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        AntiVM.init()

        thread {
            val emu = AntiVM.isEmulator()
            val root = AntiVM.isRooted()
            val hook = AntiVM.isHooked()
            val vm = AntiVM.isInVM()
            val msg = "emu => $emu, root => $root, hook => $hook, vm => $vm"
            Log.e("ANTIVM", msg)
            runOnUiThread {
                tvAntiVM.text = msg
            }
        }

    }
}
