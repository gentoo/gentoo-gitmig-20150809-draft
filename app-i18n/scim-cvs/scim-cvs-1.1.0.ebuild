# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-cvs/scim-cvs-1.1.0.ebuild,v 1.1 2004/11/30 08:11:03 usata Exp $

inherit gnome2 eutils cvs

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://freedesktop.org/~suzhe/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~amd64"
IUSE="gnome gtk immqt immqt-bc"

ECVS_AUTH="ext"
CVS_RSH="ssh"
ECVS_SERVER="savannah.nongnu.org:/cvsroot/scim"
ECVS_SSH_HOST_KEY="savannah.nongnu.org,199.232.41.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="
ECVS_USER="anoncvs"
ECVS_PASS=""
ECVS_MODULE="scim-lib"
S="${WORKDIR}/${ECVS_MODULE}"

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
	!app-i18n/scim
	!<app-i18n/scim-chinese-0.4.0"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4"
PDEPEND="|| ( >=app-i18n/scim-m17n-0.1.2
		>=app-i18n/scim-uim-0.1.3
		>=app-i18n/scim-chinese-0.4.2
		>=app-i18n/scim-hangul-0.1.1
		>=app-i18n/scim-tables-0.4.0 )"

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
	cvs_src_unpack
	# use scim gtk2 IM module only for chinese/japanese/korean
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-gtk2immodule.patch

	cd ${S}
	./bootstrap || die "bootstrap failed"

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
