# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.7.3-r2.ebuild,v 1.1 2003/10/12 12:54:51 usata Exp $

inherit flag-o-matic

# Note that truetype, ssl and nls IUSE flags will take effect
# only if you enable cjk IUSE flag.
IUSE="ipv6 kde gnome mozilla truetype ssl cjk nls"

S=${WORKDIR}/${P}
S2=${WORKDIR}/dillo-gentoo-extras-patch3
I18N_P=${P}-i18n-misc-20031012

DESCRIPTION="Lean GTK+-based web browser"
HOMEPAGE="http://dillo.auriga.wearlab.de/"
SRC_URI="http://www.dillo.org/download/${P}.tar.bz2
	mirror://gentoo/dillo-gentoo-extras-patch3.tar.bz2
	cjk? ( http://teki.jpn.ph/pc/software/${I18N_P}.diff.bz2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

replace-flags "-O2 -mcpu=k6" "-O2 -mcpu=pentium"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use cjk && epatch ../${I18N_P}.diff

	if [ "${DILLO_ICONSET}" = "kde" ]
	then
		ebegin "Using Konqueror style icon set"
		cp ${S2}/pixmaps.konq.h ${S}/src/pixmaps.h
		eend 0
	elif [ "${DILLO_ICONSET}" = "gnome" ]
	then
		ebegin "Using Ximian style icon set"
		cp ${S2}/pixmaps.ximian.h ${S}/src/pixmaps.h
		eend 0
	elif [ "${DILLO_ICONSET}" = "mozilla" ]
	then
		ebegin "Using Netscape style icon set"
		cp ${S2}/pixmaps.netscape.h ${S}/src/pixmaps.h
		eend 0
	elif [ "${DILLO_ICONSET}" = "bold" ]
	then
		ebegin "Using bold style icon set"
		cp ${S2}/pixmaps.bold.h ${S}/src/pixmaps.h
		eend 0
	elif [ "${DILLO_ICONSET}" = "trans" ]
	then
		ebegin "Using transparent style icon set"
		cp ${S2}/pixmaps.trans.h ${S}/src/pixmaps.h
		eend 0
	else
		ebegin "Using default Dillo icon set"
		eend 0
	fi
}

src_compile() {
	local myconf

	if [ -n "`use cjk`" ] ; then
		if [ -n "`use truetype`" ] ; then
			CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
			LDFLAGS="${LDFLAGS} -L/usr/X11R6/lib -lXft"
			export CPPFLAGS LDFLAGS
		fi
		myconf="`use_enable nls`
			`use_enable ssl`
			`use_enable truetype anti-alias`
			--enable-meta-refresh"
	fi

	econf `use_enable ipv6` \
		${myconf} || die
	emake || make || die
}

src_install() {
	dodir /etc  /usr/share/icons/${PN}
	einstall || die

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
