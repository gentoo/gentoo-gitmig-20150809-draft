# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.7.3-r1.ebuild,v 1.6 2004/02/23 09:46:34 mr_bones_ Exp $

inherit flag-o-matic

S2=${WORKDIR}/dillo-gentoo-extras-patch3

DESCRIPTION="Lean GTK+-based web browser"
HOMEPAGE="http://www.dillo.org/"
SRC_URI="http://www.dillo.org/download/${P}.tar.bz2
	mirror://gentoo/dillo-gentoo-extras-patch3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~hppa"
IUSE="ipv6 kde gnome mozilla"


DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ "${DILLO_ICONSET}" = "kde" ]
	then
		einfo "Using Konqueror style icon set"
		cp ${S2}/pixmaps.konq.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "gnome" ]
	then
		einfo "Using Ximian style icon set"
		cp ${S2}/pixmaps.ximian.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "mozilla" ]
	then
		einfo "Using Netscape style icon set"
		cp ${S2}/pixmaps.netscape.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "bold" ]
	then
		einfo "Using bold style icon set"
		cp ${S2}/pixmaps.bold.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "trans" ]
	then
		einfo "Using transparent style icon set"
		cp ${S2}/pixmaps.trans.h ${S}/src/pixmaps.h
	else
		einfo "Using default Dillo icon set"
	fi
}

src_compile() {
	replace-flags "-O2 -mcpu=k6" "-O2 -mcpu=pentium"
	econf `use_enable ipv6` || die
	emake || make || die
}

src_install() {
	dodir /etc  /usr/share/icons/${PN}
	einstall

	dodoc AUTHORS COPYING ChangeLog* INSTALL README NEWS
	docinto doc
	dodoc doc/*.txt doc/README

	cp ${S2}/icons/*.png ${D}/usr/share/icons/${PN}
}

pkg_postinst() {
	einfo "This ebuild for dillo comes with different toolbar icons"
	einfo "If you want mozilla style icons then try"
	einfo "	DILLO_ICONSET=\"mozilla\" emerge dillo"
	einfo
	einfo "If you prefer konqueror style icons then try"
	einfo "	DILLO_ICONSET=\"kde\" emerge dillo"
	einfo
	einfo "If you prefer ximian gnome style icons then try"
	einfo "	DILLO_ICONSET=\"gnome\" emerge dillo"
	einfo
	einfo "If you prefer bold style icons then try"
	einfo "	DILLO_ICONSET=\"bold\" emerge dillo"
	einfo
	einfo "If you prefer transparent style icons then try"
	einfo "	DILLO_ICONSET=\"trans\" emerge dillo"
	einfo
	einfo "If the DILLO_ICONSET variable is not set, you will get the"
	einfo "default iconset"
	einfo
	einfo "To see what the icons look like, please point your browser to:"
	einfo "http://dillo.auriga.wearlab.de/Icons/"
	einfo
}
