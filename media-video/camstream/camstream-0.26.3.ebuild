# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camstream/camstream-0.26.3.ebuild,v 1.7 2004/07/14 21:31:49 agriffis Exp $

inherit eutils gnuconfig

DESCRIPTION="Collection of tools for webcams and other video devices"
HOMEPAGE="http://www.smcc.demon.nl/camstream/"
SRC_URI="http://www.smcc.demon.nl/camstream/download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 -ppc"
SLOT="0"
IUSE="doc"

DEPEND=">=x11-libs/qt-3"

src_unpack () {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	# Camstream has 32 bit asssembler normally.
	use amd64 && epatch ${FILESDIR}/x86_64-asm.patch
}

src_compile () {
	# Need to fake out Qt or we'll get sandbox problems
	REALHOME="$HOME"
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	dobin camstream/camstream camstream/caminfo camstream/ftpput
	dodir /usr/share/${PN}/icons
	insinto /usr/share/${PN}/icons
	doins camstream/icons/*.png
	use doc && dohtml -r docs/*
}
