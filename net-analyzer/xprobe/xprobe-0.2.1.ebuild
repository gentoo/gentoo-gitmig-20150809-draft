# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xprobe/xprobe-0.2.1.ebuild,v 1.5 2005/03/30 03:23:15 ka0ttic Exp $

inherit eutils

# This is new xprobe, so called xprobe2, due to xprobe1 being obsoleted.
# xprobe 2 has different approach to operating system fingerprinting. 
# Xprobe2 rely on fuzzy signature matching, probabilistic guesses, multiple
# matches simultaneously, and a signature database.
#
DESCRIPTION="Active OS fingerprinting tool - this is Xprobe2"
SRC_URI="mirror://sourceforge/${PN}/${PN}2-${PV}.tar.gz"
HOMEPAGE="http://www.sys-security.com/index.php?page=xprobe"

KEYWORDS="x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libpcap"

src_compile() {
	cd "${WORKDIR}/${PN}2-${PV}"
	# needed due to broken configure script
	unset CFLAGS
	unset CXXFLAGS
	econf || die "could not configure"
	emake || die "could not make"
}

src_install () {
	cd "${WORKDIR}/${PN}2-${PV}"
	make DESTDIR=${D} install || die
	dodoc AUTHORS CREDITS COPYING
	dodoc CHANGELOG TODO README
	dodoc docs/*
}

