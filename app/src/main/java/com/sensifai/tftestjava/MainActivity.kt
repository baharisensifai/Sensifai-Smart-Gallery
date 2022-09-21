package com.sensifai.tftestjava

import android.content.Context
import android.content.res.AssetManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContentProviderCompat.requireContext
import com.sensifai.tftestjava.ml.Model
import org.tensorflow.lite.DataType
import org.tensorflow.lite.support.image.TensorImage
import org.tensorflow.lite.support.tensorbuffer.TensorBuffer
import java.io.IOException
import java.io.InputStream
import java.util.*


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val button: Button = findViewById(R.id.button)

        button.setOnClickListener {
            val model = Model.newInstance(this@MainActivity)

            val inputFeature0 = TensorBuffer.createFixedSize(intArrayOf(512, 512, 3), DataType.UINT8)
            val bitmap: Bitmap = getBitmapFromAsset(this@MainActivity, "photo_5852630279766785024_y.jpg") ?: return@setOnClickListener
            val image = TensorImage.fromBitmap(Bitmap.createScaledBitmap(bitmap, 512, 512, true))
            inputFeature0.loadBuffer(image.buffer)


            val outputs = model.process(inputFeature0)
            val outputFeature0 = outputs.outputFeature0AsTensorBuffer

            val file_name = "labels.txt"
            val labels = Labels(this@MainActivity)
            val responses = outputFeature0.floatArray
            val x = ArrayList<Confidence>()
            for (i in 0 until responses.size){
                x.add(Confidence(i, responses[i], labels.getLabelByIndex(i )))
            }


            Collections.sort(x) {
                    o1, o2 -> o2.rate.compareTo(o1.rate)
            }



            model.close()
        }
    }

    private fun getBitmapFromAsset(context: Context, filePath: String): Bitmap? {
        val assetManager: AssetManager = context.assets
        val istr: InputStream
        var bitmap: Bitmap? = null
        try {
            istr = assetManager.open(filePath)
            bitmap = BitmapFactory.decodeStream(istr)
        } catch (e: IOException) {
            // handle exception
        }
        return bitmap
    }

}