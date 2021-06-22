# Installing Dependencies
apt-get update;
apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler git ccache wget;

# Cloning Bitcoin Source
git clone https://github.com/bitcoin/bitcoin.git;

# Installing Berkeley DB (BDB) v4.8
cd bitcoin;
./contrib/install_db4.sh `pwd`;
export BDB_PREFIX='/bitcoin/db4';

# Compiling Bitcoin from source
./autogen.sh;
./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" --enable-gprof;
make;

# Running unit tests
make check;

# Running functional tests
test/functional/test_runner.py --extended;
