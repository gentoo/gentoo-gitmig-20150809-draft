# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.6.6-r3.ebuild,v 1.5 2003/09/06 01:54:08 msterret Exp $

inherit eutils
S2=${WORKDIR}/gentoo-dillo-extras-patch
EPATCH_SOURCE="${S2}"
EPATCH_SUFFIX="patch"

DESCRIPTION="Lean GTK+-based web browser"
SRC_URI="http://dillo.cipsga.org.br/download/${P}.tar.gz
	mirror://gentoo/gentoo-dillo-extras-patch.tar.bz2"
HOMEPAGE="http://dillo.cipsga.org.br/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use libwww
	    then
		epatch
		export WANT_AUTOMAKE_1_4=1
		automake
	fi

	if use mozilla
	then
		cp ${S2}/pixmaps.netscape.h ${S}/src/pixmaps.h
	elif use kde
	then
		cp ${S2}/pixmaps.konq.h ${S}/src/pixmaps.h
	elif use gnome
	then
		cp ${S2}/pixmaps.ximian.h ${S}/src/pixmaps.h
	fi
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /etc
	einstall
	dodoc AUTHORS COPYING ChangeLog ChangeLog.old INSTALL README NEWS
	docinto doc
	dodoc doc/*.txt doc/README
}

pkg_postinst() {
	einfo "This ebuild for dillo comes with different toolbar icons"
	einfo "If you want mozilla style icons then try"
	einfo "	USE=\"-kde -gnome mozilla\" emerge dillo"
	einfo
	einfo "If you prefer konqueror style icons then try"
	einfo "	USE=\"-mozilla -gnome kde\" emerge dillo"
	einfo
	einfo "If you prefer ximian gnome style icons then try"
	einfo "	USE=\"-mozilla -kde gnome\" emerge dillo"
	einfo
	einfo "Otherwise, if you want the default icon set, then do"
	einfo "	USE=\"-mozilla -kde -gnome\" emerge dillo"
	einfo
	einfo "Do not worry, no extra dependencies will be pulled in"
}
