# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/torch/torch-3.1.ebuild,v 1.2 2010/03/15 04:48:17 bicatali Exp $

inherit toolchain-funcs multilib

DESCRIPTION="machine-learning library, written in simple C++"
HOMEPAGE="http://www.torch.ch/"
SRC_URI="http://www.torch.ch/archives/Torch${PV%.1}src.tgz
	doc? ( http://www.torch.ch/archives/Torch3doc.tgz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug doc examples"

S=${WORKDIR}/Torch${PV%.1}

TORCH_PACKAGES="convolutions datasets decoder distributions gradients kernels matrix nonparametrics speech"

src_compile() {
	local shalldebug="OPT"
	use debug && shalldebug="DBG"
	# -malign-double makes no sense on a 64-bit arch
	use amd64 || extraflags="-malign-double"
	cp config/Makefile_options_Linux .
	sed -i \
		-e "s:^PACKAGES.*:PACKAGES = ${TORCH_PACKAGES}:" \
		-e "s:^DEBUG.*:DEBUG = ${shalldebug}:" \
		-e "s:^CFLAGS_OPT_FLOAT.*:CFLAGS_OPT_FLOAT = ${CFLAGS} -ffast-math ${extraflags}:" \
		Makefile_options_Linux

	emake -j1 depend || die
	emake || die "emake failed"
}

src_install() {
	dolib lib/*/*.a || die
	insinto /usr/include/torch
	for directory in core ${TORCH_PACKAGES}; do
		doins ${directory}/*.h || die
	done

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi

	if use doc; then
		cd "${WORKDIR}"/docs
		doins *.pdf || die
		dohtml -r manual/. || die
	fi
}
