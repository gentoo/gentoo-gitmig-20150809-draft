# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mono-wine/mono-wine-20030318.ebuild,v 1.3 2004/04/06 03:50:15 vapier Exp $

inherit eutils

DESCRIPTION="Wine for mono's System.Windows.Forms"
HOMEPAGE="http://www.go-mono.com/winforms.html/"
SRC_URI="http://primates.ximian.com/~duncan/mono-wine/sources/Wine-${PV}.tar.gz
	 http://primates.ximian.com/~duncan/mono-wine/sources/mono-wine.patch
	 http://primates.ximian.com/~duncan/mono-wine/sources/dot-wine.tar.gz
	 http://primates.ximian.com/~duncan/mono-wine/sources/mono-wine-setup"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

S=${WORKDIR}/wine-${PV}

src_compile() {
	epatch ${DISTDIR}/mono-wine.patch
	econf || die
	make wine-shared || die
}

src_install() {
	make DESTDIR=${D} wine-shared-install || die
	dobin ${DISTDIR}/mono-wine-setup
	mkdir -p ${D}/usr/lib/mono-wine/
	cp ${DISTDIR}/dot-wine.tar.gz ${D}/usr/lib/mono-wine/
	chmod -R a+r ${D}/usr/lib/mono-wine/
}

pkg_postinst() {
	einfo "You must run /usr/bin/mono-wine-setup to enable SWF."
	einfo "This wine install is very beta, please report any bugs at"
	einfo "http://bugs.gentoo.org"
}
