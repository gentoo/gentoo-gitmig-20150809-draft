# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-2.4.ebuild,v 1.1 2004/07/03 23:52:51 fvdpol Exp $

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.source.tgz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="x11-libs/qt
	virtual/tetex"

RDEPEND="${DEPEND}
	 virtual/mpg123"

src_compile() {
	addwrite "${QTDIR}/etc/settings"

	cp defines.gentoo defines
	make ${MAKEOPTS} CPP=g++ CC=gcc VARTEXFONTS=${T}/fonts || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
	mv ${D}/usr/share/doc/{${PN},${PF}}
}
