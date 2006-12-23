# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-1.4.5-r1.ebuild,v 1.4 2006/12/23 19:15:02 dertobi123 Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit eutils flag-o-matic autotools

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="doc gtk kde qt3"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2
		>=dev-libs/atk-1
		>=x11-libs/pango-1
		>=dev-libs/glib-2 )
	!app-i18n/scim-cvs"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )
	doc? ( app-doc/doxygen
		app-text/docbook-xsl-stylesheets )
	dev-lang/perl
	dev-util/pkgconfig
	>=dev-util/intltool-0.33"

PDEPEND="!alpha? ( !hppa? ( kde? ( app-i18n/skim ) ) )
	!alpha? ( !hppa? ( !sparc? ( qt3? ( || ( app-i18n/scim-qtimm app-i18n/scim-bridge ) ) ) ) )"

get_gtk_confdir() {
	if use amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && use x86 ) ; then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-imengine.patch
	epatch "${FILESDIR}"/${P}-fbsd.patch

	if use doc ; then
		local xsl=$(ls -1d /usr/share/sgml/docbook/xsl-stylesheets* | head -n 1)
		sed -i -e "s:/usr/share/sgml/docbook/xsl-stylesheets:${xsl}:" configure.ac || die
	fi
	eautoreconf
}

src_compile() {
	local myconf
	# bug #83625
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# We cannot use "use_enable"
	if ! use gtk ; then
		myconf="${myconf} --disable-panel-gtk"
		myconf="${myconf} --disable-setup-ui"
		myconf="${myconf} --disable-gtk2-immodule"
	fi

	econf \
		$(use_with doc doxygen) \
		--enable-ld-version-script \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS ChangeLog docs/developers docs/scim.cfg
	use doc && dohtml -r docs/html/*
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
	einfo "	# emerge app-i18n/scim-anthy"
	einfo "To use various input methods (more than 30 languages):"
	einfo "	# emerge app-i18n/scim-m17n"
	einfo
	ewarn
	ewarn "If you upgraded from scim-1.2.x or scim-1.0.x, you should remerge all SCIM modules."
	ewarn
	epause 10

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}

pkg_postrm() {

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}
