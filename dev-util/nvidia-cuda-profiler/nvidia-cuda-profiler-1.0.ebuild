# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-profiler/nvidia-cuda-profiler-1.0.ebuild,v 1.4 2009/08/07 14:27:10 chainsaw Exp $

DESCRIPTION="NVIDIA CUDA Visual Profiler"
HOMEPAGE="http://developer.nvidia.com/cuda"

SRC_URI="http://developer.download.nvidia.com/compute/cuda/2.0-Beta2/profiler/CudaVisualProfiler_linux_1.0_13June08.tar.gz
		http://developer.download.nvidia.com/compute/cuda/2.0-Beta2/docs/CudaVisualProfiler_README_1.0_13June08.txt"
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-util/nvidia-cuda-toolkit
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

S="${WORKDIR}"

src_install() {
	unset ABI
	into /opt/cuda
	dobin CudaVisualProfiler/bin/cudaprof
	dolib CudaVisualProfiler/bin/*.so*

	insinto /opt/cuda/doc
	doins "${DISTDIR}"/CudaVisualProfiler_README_1.0_13June08.txt
}
