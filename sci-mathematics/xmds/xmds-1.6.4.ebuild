# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/xmds/xmds-1.6.4.ebuild,v 1.2 2008/01/21 03:24:51 mr_bones_ Exp $

doc_ver=20080110

DESCRIPTION="XMDS - The eXtensible Multi-Dimensional Simulator"
HOMEPAGE="http://www.xmds.org"
SRC_URI="mirror://sourceforge/xmds/${P}.tar.gz
	 doc? ( mirror://sourceforge/xmds/xmds_doc${doc_ver}.pdf )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples mpi threads"

DEPEND="sci-libs/fftw
		mpi? ( virtual/mpi )"

src_unpack() {
	unpack ${P}.tar.gz
}

src_compile() {
	local my_opts=""

	if has_version "=sci-libs/fftw-3*" ; then
		my_opts="${my_opts} --enable-fftw3"
	fi

	econf \
		$(use_enable mpi) \
		$(use_enable threads) \
		${my_opts} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}/xmds_doc${doc_ver}.pdf"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
