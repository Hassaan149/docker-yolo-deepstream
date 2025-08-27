FROM nvcr.io/nvidia/deepstream:7.1-triton-multiarch

WORKDIR /opt/nvidia/deepstream/deepstream-7.1

RUN apt-get update && rm -rf /var/lib/apt/lists/* && apt-get install -y libavcodec58

COPY DeepStream-Yolo /opt/nvidia/deepstream/deepstream/sources/DeepStream-Yolo

WORKDIR /opt/nvidia/deepstream/deepstream/sources/DeepStream-Yolo
ENV CUDA_VER=12.6
RUN make -C nvdsinfer_custom_impl_Yolo clean && make -C nvdsinfer_custom_impl_Yolo
COPY configs/ /opt/nvidia/deepstream/deepstream/sources/DeepStream-Yolo
COPY start.sh DeepStream-YOLO/
EXPOSE 5000
RUN chmod +x /opt/nvidia/deepstream/deepstream/sources/DeepStream-Yolo/DeepStream-YOLO/start.sh
CMD ["/opt/nvidia/deepstream/deepstream/sources/DeepStream-Yolo/DeepStream-YOLO/start.sh"]
