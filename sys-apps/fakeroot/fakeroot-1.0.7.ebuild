# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-1.0.7.ebuild,v 1.1 2004/11/02 21:22:40 agriffis Exp $

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://joostje.op.het.net/fakeroot/index.html"
SRC_URI="mirror://debian/pool/main/f/fakeroot/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
IUSE=""

RDEPEND="virtual/libc"

src_compile() {
	mkdir obj-tcp obj

	cd ${S}/obj-tcp || die
	../configure \
		--prefix=/usr --mandir=/usr/share/man \
		--with-ipc=tcp --program-suffix=-tcp || die
	emake || die

	cd ${S}/obj || die
	../configure \
		--prefix=/usr --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	local f

	cd ${S}/obj-tcp
	make DESTDIR=${D} install || die "install problem"
	cd ${D}/usr/lib; for f in *; do mv -v ${f} ${f%%.*}-tcp.${f#*.}; done
	sed -i -e 's/\(libfakeroot\)\./\1-tcp./g' libfakeroot-tcp.la

	cd ${S}/obj
	make DESTDIR=${D} install || die "install problem"
}
