# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.5.10b.ebuild,v 1.13 2003/12/26 12:20:26 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Library"
SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc virtual/alsa"
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 -sparc ~alpha"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	make || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING

}
