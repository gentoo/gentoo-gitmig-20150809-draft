# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/peps/peps-2.0.ebuild,v 1.1 2007/05/16 07:00:28 sbriesen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Peps preprocesses EPS files and passes it to Ghostscript for conversion into a bitmap"
HOMEPAGE="http://peps.redprince.net/peps/"
SRC_URI="http://www.peps.redprince.net/peps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="virtual/ghostscript
	app-arch/gzip"

pkg_setup() {
	if use X && ! grep -q x11gray4 <(gs -h 2>/dev/null); then
		die "you need a ghostscript version with 'x11' and 'x11gray4' devices!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# adding <string.h> include
	sed -i -e "s:^\(#include.*<unistd.h>.*\):\1\n#include <string.h>:" peps.c
}

src_compile() {
	local myopts="peps"
	use X && myopts="${myopts} xpeps"
	emake CC="$(tc-getCC)" ${myopts} || die "emake failed"
}

src_install() {
	# manual install, because fixing dumb Makefile is more compilcated
	dobin peps || die "install failed"
	use X && dobin xpeps

	doman peps.1
	dodoc README

	insinto /etc
	doins peps.mime

	# copy PDF so it won't be compressed
	cp peps.pdf "${D}usr/share/doc/${PF}"
}
