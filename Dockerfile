FROM acusensehub/keras-theano:cpu

VOLUME ["/home/_data", "/home/_inputs", "/home/_outputs", "/home/src"]

# set keras backend to theano
ENV KERAS_BACKEND=theano

# Setup environment variables
ENV INPUT_DIR=/home/_inputs
ENV OUTPUT_DIR=/home/_outputs
ENV DATA_DIR=/home/_data
ENV SRC_DIR=/home/src

# Run commands to make code work
RUN sudo apt-get update -y
RUN sudo apt-get install graphviz -y
RUN sudo apt-get install libopencv-dev python-opencv -y
RUN sudo apt-get install python-skimage -y

# Numpy / Scipy reqs
RUN sudo apt-get install python-numpy
RUN sudo apt-get install python-scipy
RUN sudo apt-get install python-matplotlib
RUN sudo apt-get install ipython -y
RUN sudo apt-get install ipython-notebook -y
RUN sudo apt-get install python-pandas -y
RUN sudo apt-get install python-sympy -y
RUN sudo apt-get install python-nose -y

#import the correct Keras config
COPY src/keras.json /root/.keras/keras.json

RUN mkdir -p /home/src

COPY src /home/src

RUN find /home/src/scripts -name "*.sh" -exec chmod +x {} +

# Working directory: this is where unix scripts will run from
WORKDIR /home/src