# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.94.0-r1.ebuild,v 1.1 2005/02/01 18:40:27 lanius Exp $

inherit libtool flag-o-matic multilib

DESCRIPTION="An OSF/Motif(R) clone"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc64 ~hppa ~alpha ~ppc-macos"
SLOT="0"
IUSE=""
DEPEND="virtual/libc
	virtual/x11
	!virtual/motif"

PROVIDE="virtual/motif"

src_compile() {
	use ppc-macos || elibtoolize

	if use ppc-macos; then
		append-ldflags -L/usr/X11R6/lib -lX11 -lXt
	fi

	econf \
	  --enable-production \
	  --enable-verbose=no \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"

	# cleanup
	rm -fR ${D}/usr/lib64/LessTif/
	rm -fR ${D}/usr/share/aclocal

	# move docs
	dodir /usr/share/doc/${P}
	mv ${D}/usr/LessTif/* ${D}/usr/share/doc/${P}/
	rm -fR ${D}/usr/LessTif/

	# move config files
	dodir /etc/X11
	mv ${D}/usr/$(get_libdir)/X11/* ${D}/etc/X11
	dosym /etc/X11/mwm /usr/$(get_libdir)/X11/mwm
}
