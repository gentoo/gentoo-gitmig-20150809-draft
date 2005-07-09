# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-1.9.ebuild,v 1.12 2005/07/09 15:26:59 swegener Exp $

inherit eutils

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.sourceforge.net/"

SRC_URI="ftp://progpc26.vub.ac.be/pub/bpmdj/1.9/bpmdj-1.9.source.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""

DEPEND="x11-libs/qt
	virtual/tetex"

RDEPEND="${DEPEND}
	 !ppc? ( media-sound/alsamixergui )
	 virtual/mpg123"

src_compile() {
	addwrite "${QTDIR}/etc/settings"

	make VARTEXFONTS=${T}/fonts || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
	mv ${D}/usr/share/doc/{${PN},${PF}}
}
