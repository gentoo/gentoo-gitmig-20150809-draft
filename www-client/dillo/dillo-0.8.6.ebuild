# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dillo/dillo-0.8.6.ebuild,v 1.13 2008/05/19 23:41:14 truedfx Exp $

inherit flag-o-matic eutils autotools

S2=${WORKDIR}/dillo-gentoo-extras-patch4
DILLO_I18N_P="${P}-i18n-misc-20060625"

DESCRIPTION="Lean GTK+-based web browser"
HOMEPAGE="http://www.dillo.org/"
SRC_URI="http://www.dillo.org/download/${P}.tar.bz2
	mirror://gentoo/dillo-gentoo-extras-patch4.tar.bz2
	http://teki.jpn.ph/pc/software/${DILLO_I18N_P}.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~mips ppc ppc64 sparc x86"
MISC_IUSE="nls truetype"
IUSE="${MISC_IUSE} ipv6 ssl"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${DILLO_I18N_P}.diff
	epatch "${FILESDIR}"/${PN}-build-fix.patch
	epatch "${FILESDIR}"/${PN}-asneeded.patch
	epatch "${FILESDIR}"/${PN}-ac_subst.patch
	AT_M4DIR="${S}/m4" eautoreconf

	if [ "${DILLO_ICONSET}" = "kde" ]
	then
		einfo "Using Konqueror style icon set"
		cp "${S2}"/pixmaps.konq.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "gnome" ]
	then
		einfo "Using Ximian style icon set"
		cp "${S2}"/pixmaps.ximian.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "mozilla" ]
	then
		einfo "Using Netscape style icon set"
		cp "${S2}"/pixmaps.netscape.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "cobalt" ]
	then
		einfo "Using Cobalt style icon set"
		cp "${S2}"/pixmaps.cobalt.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "bold" ]
	then
		einfo "Using bold style icon set"
		cp "${S2}"/pixmaps.bold.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "trans" ]
	then
		einfo "Using transparent style icon set"
		cp "${S2}"/pixmaps.trans.h "${S}"/src/pixmaps.h
	elif [ "${DILLO_ICONSET}" = "trad" ]
	then
		einfo "Using the traditional icon set"
		cp "${S2}"/pixmaps.trad.h "${S}"/src/pixmaps.h
	else
		einfo "Using default Dillo icon set"
	fi
}

src_compile() {
	replace-cpu-flags k6 pentium
	is-flag -O? || append-flags "-O2"

	local myconf

	# misc features
	myconf="$(use_enable nls)
		$(use_enable truetype anti-alias)
		--disable-gtktest
		--disable-dlgui
		--enable-tabs
		--enable-meta-refresh"

	myconf="${myconf}
		$(use_enable ipv6)
		$(use_enable ssl)"

	econf ${myconf}
	emake -j1 || die "emake failed."
}

src_install() {
	dodir /etc
	dodir /usr/share/icons/${PN}
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog* README NEWS
	docinto doc
	dodoc doc/*.txt doc/README

	cp ${S2}/icons/*.png "${D}"/usr/share/icons/${PN}
}

pkg_postinst() {
	elog "This ebuild for dillo comes with different toolbar icons"
	elog "If you want mozilla style icons then try"
	elog "	DILLO_ICONSET=\"mozilla\" emerge dillo"
	elog
	elog "If you prefer konqueror style icons then try"
	elog "	DILLO_ICONSET=\"kde\" emerge dillo"
	elog
	elog "If you prefer ximian gnome style icons then try"
	elog "	DILLO_ICONSET=\"gnome\" emerge dillo"
	elog
	elog "If you prefer cobalt style icons then try"
	elog "	DILLO_ICONSET=\"cobalt\" emerge dillo"
	elog
	elog "If you prefer bold style icons then try"
	elog "	DILLO_ICONSET=\"bold\" emerge dillo"
	elog
	elog "If you prefer transparent style icons then try"
	elog "	DILLO_ICONSET=\"trans\" emerge dillo"
	elog
	elog "If you prefer the traditional icons then try"
	elog "	DILLO_ICONSET=\"trad\" emerge dillo"
	elog
	elog "If the DILLO_ICONSET variable is not set, you will get the"
	elog "default iconset"
	elog
	elog "To see what the icons look like, please point your browser to:"
	elog "http://dillo.auriga.wearlab.de/Icons/"
	elog
}
