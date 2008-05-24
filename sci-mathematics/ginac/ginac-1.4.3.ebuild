# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ginac/ginac-1.4.3.ebuild,v 1.2 2008/05/24 20:31:29 markusle Exp $

inherit eutils

DESCRIPTION="C++ library and tools for symbolic calculations"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${P}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="sci-libs/cln"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen media-gfx/transfig virtual/latex-base )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}"/${PN}-1.4.1-gcc4.3.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use doc; then
		# need to run twice to get the references right (you know, latex)
		# do not add die function at the first one
		make pdf
		emake pdf || die "emake pdf failed"
		cd doc/reference
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS || die

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/reference/reference.pdf
		dohtml -r doc/reference/html_files/*
	fi
}
