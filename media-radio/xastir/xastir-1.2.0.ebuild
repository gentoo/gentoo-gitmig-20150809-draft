# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xastir/xastir-1.2.0.ebuild,v 1.3 2003/09/11 01:39:53 msterret Exp $

DESCRIPTION="XASTIR"
HOMEPAGE="http://xastir.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	virtual/motif"

src_compile() {
	cd ${S}
	./configure --host=${CHOST} \
	   --prefix=/usr || die
	pmake || die
}

src_install() {
	into /
	make DESTDIR=${D} install || die
	mkdir -p ${D}/usr/local
	dosym ../xastir usr/local/xastir
}
