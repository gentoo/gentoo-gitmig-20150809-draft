# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmidecode/dmidecode-2.5.ebuild,v 1.1 2004/11/29 20:07:40 chainsaw Exp $

inherit flag-o-matic

DESCRIPTION="DMI (Desktop Management Interface) table related utilities"
HOMEPAGE="http://www.nongnu.org/dmidecode/"
SRC_URI="http://savannah.nongnu.org/download/dmidecode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	use ia64 && append-flags -D__IA64__
	sed -i \
		-e "s:-O2:${CFLAGS}${ARCHFLAGS}:" \
		-e "s:man/man8:share/man/man8:g" \
		-e "s:/usr/local:${D}/usr:" \
		Makefile || die "manpage sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/sbin /usr/share/man/man8
	make install || die "make install failed"
	dodoc README AUTHORS CHANGELOG
}
