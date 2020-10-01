# for repo in libfluid_base libfluid_msg
# do
#     cd $repo
#     patch_files=${SCRIPT_DIR}/${repo}_patches/*
#     for patch in $patch_files
#     do
#         git apply $patch
#     done
#     # Configure and compile
#     ./autogen.sh
#     ./configure 
#     # --prefix=/usr/local --with-gnu-ld=yes
#     make
#     make install 
#     #   DESTDIR=${WORK_DIR}/install
#     cd ../
# done


#!/bin/bash
#
# Copyright 2020 The Magma Authors.

# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Generate the debian package from source for libfluid msg/base
# Example output:
#   magma-libfluid_0.1.0-1_amd64.deb

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source /magma/third_party/build/lib/util.sh
PATCH_DIR=/magma/third_party/build/patches/libfluid

GIT_VERSION=0.1.0
ITERATION=1
PKGVERSION=${GIT_VERSION}.5
VERSION="${PKGVERSION}"-"${ITERATION}"
PKGNAME=magma-libfluid

function buildrequires() {
    echo g++ make libtool pkg-config libevent-dev libssl-dev
}

if_subcommand_exec

WORK_DIR=/tmp/build-${PKGNAME}

# Commit on the origin/0.2 branch, which has a lot of fixes
LIBFLUID_BASE_COMMIT=56df5e20c49387ab8e6b5cd363c6c10d309f263e
# Latest master commit with fixes passed v0.1.0
LIBFLUID_MSG_COMMIT=71a4fccdedfabece730082fbe87ef8ae5f92059f

# The resulting package is placed in $OUTPUT_DIR
# or in the cwd.
if [ -z "$1" ]; then
  OUTPUT_DIR=`pwd`
else
  OUTPUT_DIR=$1
  if [ ! -d "$OUTPUT_DIR" ]; then
    echo "error: $OUTPUT_DIR is not a valid directory. Exiting..."
    exit 1
  fi
fi

# build from source
if [ -d ${WORK_DIR} ]; then
  rm -rf ${WORK_DIR}
fi
mkdir ${WORK_DIR}
cd ${WORK_DIR}

# Clone repos and checkout latest commit
git clone https://github.com/OpenNetworkingFoundation/libfluid_base.git
git -C libfluid_base checkout $LIBFLUID_BASE_COMMIT

pushd libfluid_base
git apply "${PATCH_DIR}"/libfluid_base_patches/ExternalEventPatch.patch
popd

git clone https://github.com/OpenNetworkingFoundation/libfluid_msg.git
git -C libfluid_msg checkout $LIBFLUID_MSG_COMMIT

pushd libfluid_msg
git apply "${PATCH_DIR}"/libfluid_msg_patches/TunnelDstPatch.patch
git apply "${PATCH_DIR}"/libfluid_msg_patches/Add-support-for-setting-OVS-reg8.patch
popd

for repo in libfluid_base libfluid_msg
do
  cd $repo
  # Configure and compile
  ./autogen.sh
  ./configure #--prefix=/usr
  make
  make install #DESTDIR=${WORK_DIR}/install
  cd ../
done
# # packaging
# PKGFILE="$(pkgfilename)"
# BUILD_PATH=${OUTPUT_DIR}/${PKGFILE}

# # remove old packages
# if [ -f ${BUILD_PATH} ]; then
#   rm ${BUILD_PATH}
# fi
# DO DEB instead ?
# fpm \
#     -s dir \
#     -t ${PKGFMT} \
#     -a ${ARCH} \
#     -n ${PKGNAME} \
#     -v ${PKGVERSION} \
#     --iteration ${ITERATION} \
#     --provides ${PKGNAME} \
#     --conflicts ${PKGNAME} \
#     --replaces ${PKGNAME} \
#     --package ${BUILD_PATH} \
#     --depends "libevent-dev" \
#     --depends "libssl-dev" \
#     --description 'Libfluid Openflow Controller' \
#     -C ${WORK_DIR}/install

# BUILD ERROR !!!!

FAILED: oai_mme/mme 
: && /usr/bin/c++ -g -DDEBUG_IS_ON=1 -fsanitize=address -fprofile-arcs -ftest-coverage  -rdynamic oai_mme/CMakeFiles/mme.dir/oai_mme.o oai_mme/CMakeFiles/mme.dir/__/common/common_types.o oai_mme/CMakeFiles/mme.dir/__/common/itti_free_defined_msg.o oai_mme/CMakeFiles/mme.dir/__/tasks/service303/service303_task.o oai_mme/CMakeFiles/mme.dir/__/tasks/service303/service303_mme_stats.o oai_mme/CMakeFiles/mme.dir/__/tasks/grpc_service/grpc_service_task.o -o oai_mme/mme  -Wl,-rpath,/usr/local/lib  -Wl,--start-group  common/libCOMMON.a  lib/3gpp/libLIB_3GPP.a  tasks/s1ap/libLIB_S1AP.a  lib/secu/libLIB_SECU.a  lib/directoryd/libLIB_DIRECTORYD.a  lib/sgs_client/libLIB_SGS_CLIENT.a  lib/bstr/libLIB_BSTR.a  lib/hashtable/libLIB_HASHTABLE.a  lib/s6a_proxy/libLIB_S6A_PROXY.a  tasks/s1ap/libTASK_S1AP.a  tasks/sctp/libTASK_SCTP_SERVER.a  tasks/sgs/libTASK_SGS.a  tasks/sms_orc8r/libTASK_SMS_ORC8R.a  tasks/s6a/libTASK_S6A.a  tasks/mme_app/libTASK_MME_APP.a  tasks/grpc_service/libTASK_GRPC_SERVICE.a  tasks/nas/libTASK_NAS.a  -Wl,--end-group  /usr/local/lib/liblfds710.a  -lpthread  -lm  -lsctp  -lrt  -lcrypt  -lcrypto  -lssl  -lcrypto  -lnettle  -lconfig  -lgnutls  /build/c/magma_common/service303/libSERVICE303_LIB.a  -lprometheus-cpp  -lgrpc  -lgrpc++  -lyaml-cpp  tasks/sgw/libTASK_SGW.a  tasks/gtpv1-u/libTASK_GTPV1U.a  lib/openflow/controller/libLIB_OPENFLOW_CONTROLLER.a  tasks/s1ap/libTASK_S1AP.a  tasks/mme_app/libTASK_MME_APP.a  tasks/nas/libTASK_NAS.a  tasks/sgw/libTASK_SGW.a  tasks/gtpv1-u/libTASK_GTPV1U.a  lib/openflow/controller/libLIB_OPENFLOW_CONTROLLER.a  lib/directoryd/libLIB_DIRECTORYD.a  tasks/sctp/libTASK_SCTP_SERVER.a  tasks/sgs/libTASK_SGS.a  lib/sgs_client/libLIB_SGS_CLIENT.a  lib/event_client/libLIB_EVENT_CLIENT.a  /build/c/magma_common/eventd/libEVENTD.a  common/redis_utils/libredis_utils.a  lib/secu/libLIB_SECU.a  tasks/s6a/libTASK_S6A.a  lib/s6a_proxy/libLIB_S6A_PROXY.a  -lcpp_redis  -ltacopie  lib/mobility_client/libLIB_MOBILITY_CLIENT.a  lib/pcef/libLIB_PCEF.a  lib/mobility_client/libLIB_MOBILITY_CLIENT.a  lib/pcef/libLIB_PCEF.a  tasks/service303/libTASK_SERVICE303.a  -lfluid_base  -lfluid_msg  lib/sms_orc8r_client/libLIB_SMS_ORC8R_CLIENT.a  /build/c/magma_common/async_grpc/libASYNC_GRPC.a  /build/c/magma_common/service_registry/libSERVICE_REGISTRY.a  /build/c/magma_common/config/libCONFIG.a  common/libCOMMON.a  lib/3gpp/libLIB_3GPP.a  tasks/s1ap/libLIB_S1AP.a  lib/hashtable/libLIB_HASHTABLE.a  lib/itti/libLIB_ITTI.a  lib/message_utils/libLIB_MESSAGE_UTILS.a  common/libCOMMON.a  lib/3gpp/libLIB_3GPP.a  tasks/s1ap/libLIB_S1AP.a  lib/hashtable/libLIB_HASHTABLE.a  lib/itti/libLIB_ITTI.a  lib/message_utils/libLIB_MESSAGE_UTILS.a  -llfds710  common/glogwrapper/libglogwrapper.a  -lglog  lib/bstr/libLIB_BSTR.a  -lczmq  -lprotobuf  /usr/local/lib/libprotobuf.so  -lpthread  -lfolly  -lpthread  -lrt  -lssl  -lnettle  -lconfig  -lgnutls  /build/c/magma_common/service303/libSERVICE303_LIB.a  -lprometheus-cpp  -lgrpc  -lgrpc++  -lyaml-cpp && :
//usr/local/lib/libfluid_base.so: undefined reference to `event_base_add_virtual'
//usr/local/lib/libfluid_base.so: undefined reference to `event_base_del_virtual'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.
Makefile:134: recipe for target 'build_oai' failed
make: *** [build_oai] Error 1
