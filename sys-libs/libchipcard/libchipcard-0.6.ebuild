# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-0.6.ebuild,v 1.4 2003/04/29 10:41:25 darkspecter Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
SRC_URI="mirror://sourceforge/libchipcard/${P}.tar.gz"
HOMEPAGE="http://www.libchipcard.de"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ssl qt kde"

DEPEND="virtual/glibc"

src_compile() {

	local myconf
	myconf="--with-pid-dir=/var/run/ --with-log-dir=/var/log/"
	use qt  || myconf="${myconf} --disable-qtapps"
	use kde || myconf="${myconf} --disable-kdeapps"
	use ssl || myconf="${myconf} --disable-ssl"
	econf ${myconf} || die
	emake || die

}

src_install () {

	make DESTDIR=${D} chroot_dir=${D} install || die
	rm -rf ${D}/var
}
