# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dillo/dillo-0.8.3.ebuild,v 1.1 2004/10/30 10:16:37 usata Exp $

inherit flag-o-matic eutils

S2=${WORKDIR}/dillo-gentoo-extras-patch4
DILLO_I18N_P="${P}-i18n-20041026"

DESCRIPTION="Lean GTK+-based web browser"
HOMEPAGE="http://www.dillo.org/"
SRC_URI="http://www.dillo.org/download/${P}.tar.bz2
	mirror://gentoo/dillo-gentoo-extras-patch4.tar.bz2
	http://teki.jpn.ph/pc/software/${DILLO_I18N_P}.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips"
#MISC_IUSE="nls truetype"
IUSE="${MISC_IUSE} ipv6 ssl"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../${DILLO_I18N_P}.diff

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
	elif [ "${DILLO_ICONSET}" = "cobalt" ]
	then
		einfo "Using Cobalt style icon set"
		cp ${S2}/pixmaps.cobalt.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "bold" ]
	then
		einfo "Using bold style icon set"
		cp ${S2}/pixmaps.bold.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "trans" ]
	then
		einfo "Using transparent style icon set"
		cp ${S2}/pixmaps.trans.h ${S}/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "trad" ]
	then
		einfo "Using the traditional icon set"
		cp ${S2}/pixmaps.trad.h ${S}/src/pixmaps.h
	else
		einfo "Using default Dillo icon set"
	fi
}

src_compile() {
	replace-flags "-O2 -mcpu=k6" "-O2 -mcpu=pentium"

	local myconf

	#myconf="$(use_enable nls)
	#	$(use_enable truetype anti-alias)
	#	--enable-tabs
	#	--enable-meta-refresh
	#	--enable-user-agent"

	myconf="$(use_enable ipv6)
		$(use_enable ssl)"

	econf ${myconf} || die
	emake || make || die
}

src_install() {
	dodir /etc  /usr/share/icons/${PN}
	einstall || die

	dosed /etc/dpidrc

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
	einfo "If you prefer cobalt style icons then try"
	einfo "	DILLO_ICONSET=\"cobalt\" emerge dillo"
	einfo
	einfo "If you prefer bold style icons then try"
	einfo "	DILLO_ICONSET=\"bold\" emerge dillo"
	einfo
	einfo "If you prefer transparent style icons then try"
	einfo "	DILLO_ICONSET=\"trans\" emerge dillo"
	einfo
	einfo "If you prefer the traditional icons then try"
	einfo "	DILLO_ICONSET=\"trad\" emerge dillo"
	einfo
	einfo "If the DILLO_ICONSET variable is not set, you will get the"
	einfo "default iconset"
	einfo
	einfo "To see what the icons look like, please point your browser to:"
	einfo "http://dillo.auriga.wearlab.de/Icons/"
	einfo
}
