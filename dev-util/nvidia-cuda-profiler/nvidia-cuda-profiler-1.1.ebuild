# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-profiler/nvidia-cuda-profiler-1.1.ebuild,v 1.1 2009/01/21 14:44:17 spock Exp $

DESCRIPTION="NVIDIA CUDA Visual Profiler"
HOMEPAGE="http://developer.nvidia.com/cuda"

SRC_URI="http://developer.download.nvidia.com/compute/cuda/2_1/cudaprof/CudaVisualProfiler_linux_1.1_15Dec08.tar.gz"
LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-2.1
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	unset ABI
	into /opt/cuda
	dobin CudaVisualProfiler/bin/cudaprof
	dolib CudaVisualProfiler/bin/*.so*

	if use doc ; then
		insinto /opt/cuda/doc
		doins CudaVisualProfiler/doc/cudaprof.*
		newins CudaVisualProfiler/doc/Changelog.txt CudaVisualProfiler_ChangeLog.txt
	fi
}

