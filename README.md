# Nvidia_Jetson_OpenCV_with_CUDA

Nvidia devices comes with OpenCV and CUDA installed. But the installed OpenCV does not support CUDA acceleration.
These scripts helps to build and install OpenCV with CUDA acceleration for Nvidia Jetson devices

### **AGX Orin**

The below commands needs to be run inside Nvidia Jetson AGX Orin device or a sysroot.

```sh
./build-opencv-with-cuda-nvidia-jetson-agx-orin.sh
```

The above script also generates .deb installers which can be reused so that you don't have to run this script again if you accidentally or intentionally remove this.

### **AGX Xavier**

The below commands needs to be run inside Nvidia Jetson AGX Xavier device or a sysroot.

```sh
./build-opencv-with-cuda-nvidia-jetson-agx-xavier.sh
```

The above script also generates .deb installers which can be reused so that you don't have to run this script again if you accidentally or intentionally remove this.

### **Nano**

The below commands needs to be run inside Nvidia Jetson Nano device or a sysroot.

```sh
./build-opencv-with-cuda-nvidia-jetson-nano.sh
```

The above script also generates .deb installers which can be reused so that you don't have to run this script again if you accidentally or intentionally remove this.

## **How to build OpenCV with CUDA inside a sysroot**

1. Create a target specific sysroot based on the device.
        Instructions on how to build sysroot can be found in the github link [here](https://github.com/ShanavasPS/Nvidia_Jetson_Sysroots)

2. Copy the target specific opencv build instructions inside the sysroot folder
        ```sh
        cp build-opencv-with-cuda-nvidia-jetson-nano.sh <path_to_sysroot_directory>
        ```

3. `chroot` into the sysroot,
        ```sh
        chroot <path_to_sysroot_directory>
        ```

4. Run the script, eg;
        ```sh
        ./build-opencv-with-cuda-nvidia-jetson-nano.sh
        ```
5. This will build and install opencv with CUDA support inside the sysroot
