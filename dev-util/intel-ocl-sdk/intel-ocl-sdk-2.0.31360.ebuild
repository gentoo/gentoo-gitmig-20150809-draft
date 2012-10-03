# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intel-ocl-sdk/intel-ocl-sdk-2.0.31360.ebuild,v 1.3 2012/10/03 19:17:05 ago Exp $

EAPI=4

MY_P=${PN//-/_}_2012_x64

inherit rpm multilib

INTEL_CL=usr/$(get_libdir)/OpenCL/vendors/intel/

DESCRIPTION="Intel's implementation of the OpenCL standard optimized for Intel processors."
HOMEPAGE="http://software.intel.com/en-us/articles/opencl-sdk/"
SRC_URI="http://registrationcenter.intel.com/irc_nas/2563/intel_sdk_for_ocl_applications_2012_x64.tgz"

LICENSE="Intel-SDP"
SLOT="0"
IUSE="tools"
KEYWORDS="amd64 -x86"

RDEPEND="app-admin/eselect-opencl
	dev-cpp/tbb
	sys-process/numactl
	tools? (
		dev-libs/boost:1.46
		sys-devel/llvm
		>=virtual/jre-1.6
	)"
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

src_prepare() {
	# Remove unnecessary and bundled stuff
	rm -rf ${INTEL_CL}/{docs,version.txt,llc}
	rm -f ${INTEL_CL}/libboost*
	rm -f ${INTEL_CL}/libtbb*
	if ! use tools; then
		rm -rf usr/bin
		rm -f ${INTEL_CL}/{ioc64,ioc.jar}
	fi
}

src_install() {
	doins -r etc

	insinto ${INTEL_CL}
	doins -r usr/include

	insopts -m 755
	newins usr/$(get_libdir)/libOpenCL.so libOpenCL.so.1
	dosym libOpenCL.so.1 ${INTEL_CL}/libOpenCL.so

	doins ${INTEL_CL}/*

	# Think of better way to do that...
	if use tools; then
		dosym /usr/$(get_libdir)/libboost_filesystem-1_46.so.1.46.1 \
			${INTEL_CL}/libboost_filesystem.so.1.46.1
		dosym /usr/$(get_libdir)/libboost_system-1_46.so.1.46.1 \
			${INTEL_CL}/libboost_system.so.1.46.1
	fi
}

pkg_postinst() {
	eselect opencl set --use-old intel
}
