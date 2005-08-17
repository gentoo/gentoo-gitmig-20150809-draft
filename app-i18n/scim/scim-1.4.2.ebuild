# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-1.4.2.ebuild,v 1.1 2005/08/17 10:26:14 usata Exp $

inherit eutils flag-o-matic

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64 ~sparc ~ppc64"
IUSE="gtk immqt immqt-bc"

GTK_DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	>=dev-libs/glib-2"
RDEPEND="virtual/x11
	gtk? ( ${GTK_DEPEND} )
	immqt? ( ${GTK_DEPEND} )
	immqt-bc? ( ${GTK_DEPEND} )
	!app-i18n/scim-cvs
	!<app-i18n/scim-chinese-0.4.0"
DEPEND="${RDEPEND}
	dev-lang/perl"

has_gtk() {
	if has_version '>=x11-libs/gtk+-2' ; then
		true
	else
		false
	fi
}

get_gtk_confdir() {
	if useq amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && useq x86 ) ; then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

src_compile() {
	# bug #83625
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	sed -i -e '/Languages/s/"\*"/"ko:ja:zh"/' extras/gtk2_immodule/imscim.cpp || die

	use gtk || use immqt || use immqt-bc || myconf="${myconf} --disable-panel-gtk --disable-setup-ui"
	has_gtk || myconf="${myconf} --disable-gtk2-immodule"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog docs/developers docs/scim.cfg
	dohtml -r docs/html/*
}

pkg_postinst() {
	einfo
	einfo "To use SCIM with both GTK2 and XIM, you should use the following"
	einfo "in your user startup scripts such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' scim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo "export GTK_IM_MODULE=\"scim\""
	einfo "export QT_IM_MODULE=\"scim\""
	einfo
	einfo "where 'your_language' can be zh_CN, zh_TW, ja_JP.eucJP or any other"
	einfo "UTF-8 locale such as en_US.UTF-8 or ja_JP.UTF-8"
	einfo
	einfo "If you prefer KDE/Qt interface, try emerge app-i18n/skim."
	einfo
	einfo "To use Chinese input methods:"
	einfo "	# emerge app-i18n/scim-tables app-i18n/scim-pinyin"
	einfo "To use Korean input methods:"
	einfo "	# emerge app-i18n/scim-hangul"
	einfo "To use Japanese input methods:"
	einfo "	# emerge app-i18n/scim-uim"
	einfo "To use various input methods (more than 30 languages):"
	einfo "	# emerge app-i18n/scim-m17n"
	einfo
	ewarn
	ewarn "If you upgraded from scim-1.2.x or scim-1.0.x, you should remerge all SCIM modules."
	ewarn
	epause 10

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}

pkg_postrm() {

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}
