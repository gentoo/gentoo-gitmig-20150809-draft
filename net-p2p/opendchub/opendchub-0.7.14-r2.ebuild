# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/opendchub/opendchub-0.7.14-r2.ebuild,v 1.1 2004/11/27 15:59:34 squinky86 Exp $

inherit eutils

DESCRIPTION="hub software for Direct Connect"
HOMEPAGE="http://opendchub.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="perl"

DEPEND="virtual/libc
	perl? ( dev-lang/perl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/opendchub-gentoo.patch
	epatch ${FILESDIR}/${PV}-telnet.patch
	epatch ${FILESDIR}/${PV}-overflow.patch
}

src_compile() {
	econf `use_enable perl` || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	if use perl ; then
		exeinto /usr/bin
		doexe ${FILESDIR}/opendchub_setup.sh
		dodir /usr/share/opendchub/scripts
		insinto /usr/share/opendchub/scripts
		doins Samplescripts/*
	fi
	dodoc Documentation/*
}

pkg_postinst() {
	if use perl ; then
		einfo
		einfo "To set up perl scripts for opendchub to use, please run"
		einfo "opendchub_setup.sh as the user you will be using opendchub as."
		einfo
	fi
}
