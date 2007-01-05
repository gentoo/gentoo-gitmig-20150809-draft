# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-cvs/scim-cvs-1.3.3.ebuild,v 1.6 2007/01/05 16:27:09 flameeyes Exp $

inherit eutils cvs

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="gtk immqt immqt-bc"

ECVS_AUTH="pserver"
ECVS_SERVER="scim.cvs.sourceforge.net:/cvsroot/scim"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_MODULE="scim"
S="${WORKDIR}/${ECVS_MODULE}"

GTK_DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	>=dev-libs/glib-2"
RDEPEND="|| ( x11-libs/libX11 virtual/x11 )
	gtk? ( ${GTK_DEPEND} )
	immqt? ( ${GTK_DEPEND} )
	immqt-bc? ( ${GTK_DEPEND} )
	!app-i18n/scim"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4"

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
	cvs_src_unpack
	# use scim gtk2 IM module only for chinese/japanese/korean
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-gtk2immodule.patch

	cd ${S}
	./bootstrap || die "bootstrap failed"
}

src_compile() {
	# bug #83625
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

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
	elog
	elog "To use SCIM with both GTK2 and XIM, you should use the following"
	elog "in your user startup scripts such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog "export GTK_IM_MODULE=\"scim\""
	elog "export QT_IM_MODULE=\"scim\""
	elog
	elog "where 'your_language' can be zh_CN, zh_TW, ja_JP.eucJP or any other"
	elog "UTF-8 locale such as en_US.UTF-8 or ja_JP.UTF-8"
	elog
	elog "If you prefer KDE/Qt interface, try emerge app-i18n/skim."
	elog
	elog "To use Chinese input methods:"
	elog "	# emerge app-i18n/scim-tables app-i18n/scim-pinyin"
	elog "To use Korean input methods:"
	elog "	# emerge app-i18n/scim-hangul"
	elog "To use Japanese input methods:"
	elog "	# emerge app-i18n/scim-uim"
	elog "To use various input methods (more than 30 languages):"
	elog "	# emerge app-i18n/scim-m17n"
	elog
	ewarn
	ewarn "If you upgraded from scim-1.2.x or scim-1.0.x,"
	ewarn "you should remerge all SCIM modules."
	ewarn
	epause 10

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}

pkg_postrm() {

	has_gtk && gtk-query-immodules-2.0 > ${ROOT}$(get_gtk_confdir)/gtk.immodules
}
