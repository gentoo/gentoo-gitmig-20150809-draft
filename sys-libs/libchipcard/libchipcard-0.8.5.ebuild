# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-0.8.5.ebuild,v 1.1 2003/05/13 16:54:33 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
SRC_URI="mirror://sourceforge/libchipcard/${P}.tar.gz"
HOMEPAGE="http://www.libchipcard.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

src_compile() {

	local myconf
	myconf="--disable-pcsc"
	use ssl || myconf="${myconf} --disable-ssl"
	use ssl || myconf="${myconf} --disable-ssl"
	econf ${myconf} || die
	emake || die

}

src_install () {

	make DESTDIR=${D} chroot_dir=${D} install || die
	rm -rf ${D}/var
}
