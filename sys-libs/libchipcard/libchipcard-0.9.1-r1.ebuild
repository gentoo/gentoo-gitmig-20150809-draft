# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-0.9.1-r1.ebuild,v 1.3 2004/01/09 21:32:39 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libchipcard is a library for easy access to chip cards via chip card readers (terminals)."
SRC_URI="mirror://sourceforge/libchipcard/${P}.tar.gz"
HOMEPAGE="http://www.libchipcard.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

src_compile() {
	sed -i -e 's:$prefix/etc:/etc:g' \
	    -e 's:${prefix}/etc:/etc:g' \
	    -e 's:$prefix/var:/var:g' \
	    -e 's:${prefix}/var:/var:g' \
	    configure

	local myconf
	myconf="--disable-pcsc"
	use ssl || myconf="${myconf} --disable-ssl"
	use ssl || myconf="${myconf} --disable-ssl"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} chroot_dir=${D} install || die
	rm -r ${D}/var
	exeinto /etc/init.d
	doexe ${FILESDIR}/chipcardd
}
