# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcalendar/xcalendar-4.0.ebuild,v 1.12 2004/07/18 22:03:55 aliz Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="A simple interactive calendar program with a notebook capability"
HOMEPAGE="http://www.freebsd.org/"
SRC_URI="ftp://daemon.jp.FreeBSD.org/pub/FreeBSD-jp/ports-jp/LOCAL_PORTS/${P}+i18n.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 alpha ~amd64"
IUSE="motif"

DEPEND="virtual/x11
		motif? ( x11-libs/openmotif )"

src_compile() {
	if use motif
	then
		epatch ${FILESDIR}/${P}-motif-gentoo.diff
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
