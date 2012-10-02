# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intel-ocl-sdk/intel-ocl-sdk-2.0.31360.ebuild,v 1.1 2012/10/02 05:48:24 xarthisius Exp $

EAPI=4

MY_P=${PN//-/_}_2012_x64

inherit rpm multilib

INTEL_CL=/usr/$(get_libdir)/OpenCL/vendors/intel/

DESCRIPTION="Intel's implementation of the OpenCL standard optimized for Intel processors."
HOMEPAGE="http://software.intel.com/en-us/articles/opencl-sdk/"
SRC_URI="http://registrationcenter.intel.com/irc_nas/2563/intel_sdk_for_ocl_applications_2012_x64.tgz"
LICENSE="Intel-SDP"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 -x86"

#sys-devel/clang
#dev-libs/boost:1.46
RDEPEND="app-admin/eselect-opencl
	dev-cpp/tbb
	sys-process/numactl"
DEPEND=""

RESTRICT="mirror"
QA_EXECSTACK="${INTEL_CL/\//}libcpu_device.so
	${INTEL_CL/\//}libOclCpuBackEnd.so
	${INTEL_CL/\//}libtask_executor.so"
QA_PREBUILT="${INTEL_CL}*"

S=${WORKDIR}

src_unpack() {
	default
	rpm_unpack ./${MY_P}.rpm
}

src_install() {
	doins -r etc usr/bin
	# things that are left out: llc, ioc
	insinto ${INTEL_CL}
	doins -r usr/include

	insopts -m 755
	newins usr/lib64/libOpenCL.so libOpenCL.so.1
	dosym libOpenCL.so.1 ${INTEL_CL}/libOpenCL.so
	pushd usr/lib64/OpenCL/vendors/intel &> /dev/null
	rm -f libboost* libtbb*
	doins *.so *rtl *pch
	popd &> /dev/null
}

pkg_postinst() {
	eselect opencl set --use-old intel
}
