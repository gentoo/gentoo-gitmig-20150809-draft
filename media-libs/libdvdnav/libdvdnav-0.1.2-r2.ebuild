# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.2-r2.ebuild,v 1.5 2002/09/23 19:33:27 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for DVD navigation tools."
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="media-libs/libdvdread"

src_unpack() {

	unpack ${A}
	cd ${S}/src

	# This nice little patch that makes compilation work on gcc2
	# breaks compilation on gcc-3.1 so, don't use it if we are
	# going to be running gcc-3.1
	[ -z "${CC}" ] && export CC=gcc
	[[ "`${CC} -dumpversion`" != "3.1" ]] && \
	( patch < ${FILESDIR}/${P}-gentoo.patch || die )

}

src_compile() {

	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}
