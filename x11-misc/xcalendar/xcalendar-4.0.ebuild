# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcalendar/xcalendar-4.0.ebuild,v 1.5 2004/01/11 13:41:42 lanius Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A simple interactive calendar program with a notebook capability"
HOMEPAGE="http://www.freebsd.org/"
SRC_URI="ftp://daemon.jp.FreeBSD.org/pub/FreeBSD-jp/ports-jp/LOCAL_PORTS/${P}+i18n.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND="virtual/x11
		motif? ( x11-libs/openmotif )"

src_compile() {
	if use motif
	then
		patch -p1 < ${FILESDIR}/${P}-motif-gentoo.diff || die
	fi
	xmkmf -a
	emake || die
}

src_install() {
	dobin xcalendar
	newman xcalendar.man xcalendar.1

	dodir /etc/X11/app-defaults
	sed 's;%%XCALENDAR_LIBDIR%%;/usr/lib/xcalendar;
	     s;/usr/local/X11R5/lib/X11/;/usr/lib/;' \
		< XCalendar.sed > ${D}/etc/X11/app-defaults/XCalendar || die

	insinto /usr/lib/xcalendar
	doins *.xbm *.hlp

	dodoc README
}
