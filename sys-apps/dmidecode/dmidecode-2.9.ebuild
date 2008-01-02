# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmidecode/dmidecode-2.9.ebuild,v 1.5 2008/01/02 21:53:41 vapier Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="DMI (Desktop Management Interface) table related utilities"
HOMEPAGE="http://www.nongnu.org/dmidecode/"
SRC_URI="http://savannah.nongnu.org/download/dmidecode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 ia64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^prefix/s:/usr/local:/usr:' \
		-e "/^docdir/s:dmidecode:${PF}:" \
		Makefile || die "manpage sed failed"
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC=$(tc-getCC) \
		|| die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	prepalldocs
}
