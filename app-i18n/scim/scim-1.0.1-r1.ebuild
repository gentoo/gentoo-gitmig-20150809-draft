# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-1.0.1-r1.ebuild,v 1.1 2004/11/14 05:44:22 usata Exp $

inherit gnome2 eutils

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://freedesktop.org/~suzhe/"
SRC_URI="http://freedesktop.org/~suzhe/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64"
IUSE="gnome gtk immqt immqt-bc"

GTK_DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	>=dev-libs/glib-2"
RDEPEND="virtual/x11
	gnome? ( >=gnome-base/gconf-1.2
		>=dev-libs/libxml2-2.5
		>=gnome-base/orbit-2.8 )
	gtk? ( ${GTK_DEPEND} )
	immqt? ( ${GTK_DEPEND} )
	immqt-bc? ( ${GTK_DEPEND} )
	!app-i18n/scim-cvs
	!<app-i18n/scim-chinese-0.4.0"
DEPEND="${RDEPEND}
	dev-lang/perl"
PDEPEND="|| ( app-i18n/scim-m17n
		app-i18n/scim-uim
		app-i18n/scim-chinese
		app-i18n/scim-hangul
		app-i18n/scim-tables )"

ELTCONF="--reverse-deps"
SCROLLKEEPER_UPDATE="0"
USE_DESTDIR="1"

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

src_unpack() {
	unpack ${A}
	# use scim gtk2 IM module only for chinese/japanese/korean
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-0.6.1-gtk2immodule.patch

	# workaround for problematic makefile
	sed -i -e "s:^\(scim.*LDFLAGS.*\):\1 -ldl:g" \
		${S}/src/Makefile.* || die
	sed -i -e "s:^\(scim_make_table_LDFLAGS.*\):\1 -ldl:" \
		${S}/modules/IMEngine/Makefile.* || die
	sed -i -e "s:^LDFLAGS = :LDFLAGS = -ldl :g" \
		-e "s:^\(test.*LDFLAGS.*\):\1 -ldl:g" \
		${S}/tests/Makefile.* || die
	sed -i -e "s:GTK_VERSION=2.3.5:GTK_VERSION=2.4.0:" \
		${S}/configure || die
}

src_compile() {
	use gnome || G2CONF="${G2CONF} --disable-config-gconf"
	use gtk || use immqt || use immqt-bc || G2CONF="${G2CONF} --disable-panel-gtk --disable-setup-ui"
	has_gtk || G2CONF="${G2CONF} --disable-gtk2-immodule"
	gnome2_src_compile
}

src_install() {
	gnome2_src_install || die "install failed"
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
	einfo
	einfo "where 'your_language' can be zh_CN, zh_TW, ja_JP.eucJP or any other"
	einfo "UTF-8 locale such as en_US.UTF-8 or ja_JP.UTF-8"
	einfo
	einfo "If you prefer KDE/Qt interface, try emerge app-i18n/skim."
	einfo
	einfo "To use Chinese input methods:"
	einfo "	# emerge app-i18n/scim-tables app-i18n/scim-chinese"
	einfo "To use Korean input methods:"
	einfo "	# emerge app-i18n/scim-hangul"
	einfo "To use Japanese input methods:"
	einfo "	# emerge app-i18n/scim-uim"
	einfo "To use various input methods (more than 30 languages):"
	einfo "	# emerge app-i18n/scim-m17n"
	einfo

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}

pkg_postrm() {

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}
