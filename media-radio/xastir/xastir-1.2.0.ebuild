# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xastir/xastir-1.2.0.ebuild,v 1.6 2004/06/30 02:12:33 vapier Exp $

DESCRIPTION="XASTIR"
HOMEPAGE="http://xastir.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	x11-libs/openmotif"

src_install() {
	make DESTDIR=${D} install || die
	mkdir -p ${D}/usr/local
	dosym ../xastir usr/local/xastir
}
