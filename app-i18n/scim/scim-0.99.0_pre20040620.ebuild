# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-0.99.0_pre20040620.ebuild,v 1.1 2004/06/20 15:31:17 usata Exp $

inherit gnome2 eutils

DESCRIPTION="Smart Common Input Method (SCIM) is a Input Method (IM) development platform"
HOMEPAGE="http://freedesktop.org/~suzhe/"
#SRC_URI="http://freedesktop.org/~suzhe/sources/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P/_pre/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_pre/-}.tar.gz"
S="${WORKDIR}/scim-lib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"

RDEPEND="virtual/x11
	gnome? ( >=gnome-base/gconf-1.2
		>=dev-libs/libxml2-2.5
		>=gnome-base/ORBit2-2.8 )
	>=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	>=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/autoconf
	sys-devel/automake"
PDEPEND="app-i18n/scim-uim
	app-i18n/scim-m17n"

ELTCONF="--reverse-deps"
SCROLLKEEPER_UPDATE="0"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	# use scim gtk2 IM module only for chinese/japanese/korean
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-0.6.1-gtk2immodule.patch

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
	einfo "LANG='your_language' scim -f socket -e uim,m17n -c simple -d"
	einfo "LANG='your_language' scim -f x11 -e socket -c socket -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo
	einfo "where 'your_language' can be zh_CN, zh_TW, ja_JP.eucJP or any other"
	einfo "UTF-8 locale such as en_US.UTF-8 or ja_JP.UTF-8"
	einfo

	gtk-query-immodules-2.0 > ${ROOT}etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {

	gtk-query-immodules-2.0 > ${ROOT}etc/gtk-2.0/gtk.immodules
}
