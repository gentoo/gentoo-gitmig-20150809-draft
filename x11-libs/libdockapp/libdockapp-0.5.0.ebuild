# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdockapp/libdockapp-0.5.0.ebuild,v 1.8 2004/10/19 08:48:20 absinthe Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker Dock Applet Library"
SRC_URI="http://solfertje.student.utwente.nl/~dalroi/libdockapp/files/${P}.tar.bz2"
HOMEPAGE="http://solfertje.student.utwente.nl/~dalroi/libdockapp/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc ppc64"

DEPEND="virtual/x11"

S=${WORKDIR}/${PN/lib/}

src_unpack() {
	unpack ${A}
	cd ${S}/fonts
	epatch ${FILESDIR}/makefile-0.5.0.patch
	cd ${S}
}

src_compile() {
	libtoolize --force --copy
	aclocal
	autoconf

	econf || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README ChangeLog NEWS AUTHORS
}
