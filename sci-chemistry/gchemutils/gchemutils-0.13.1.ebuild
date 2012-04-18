# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gchemutils/gchemutils-0.13.1.ebuild,v 1.5 2012/04/18 13:21:59 ssuominen Exp $

EAPI=4
inherit gnome2 # multilib toolchain-funcs nsplugins

MY_P=gnome-chemistry-utils-${PV}

DESCRIPTION="C++ classes and Gtk+-2 widgets related to chemistry"
HOMEPAGE="http://www.nongnu.org/gchemutils/"
SRC_URI="mirror://nongnu/${PN}/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls" # nsplugin

CDEPEND="
	gnome-base/libglade:2.0
	x11-libs/goffice:0.8
	x11-libs/gtkglext
	sci-chemistry/chemical-mime-data
	sci-chemistry/bodr
	sci-chemistry/openbabel"
RDEPEND="${CDEPEND}
	gnome-extra/yelp" #271998
DEPEND="${CDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"
# nsplugin? ( net-misc/npapi-sdk )

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-schemas-install
		--disable-scrollkeeper
		--disable-dependency-tracking
		--disable-update-databases
		--disable-mozilla-plugin
		$(use_enable nls)"
	# $(use_enable nsplugin mozilla-plugin)

	#if use nsplugin; then
	#	G2CONF="${G2CONF} --with-mozilla-libdir=/usr/$(get_libdir)/${PLUGINS_DIR}"
	#fi

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Drop DEPRECATED flags, bug #388509
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED::g' \
		configure configure.ac || die

	gnome2_src_prepare
}

src_configure() {
	#if use nsplugin; then
	#	export MOZILLA_CFLAGS="$($tc-getPKG_CONFIG) --cflags npapi-sdk)"
	#	export MOZILLA_LIBS=""
	#fi

	gnome2_src_configure
}

src_test() {
	# There are no tests, and make check needlessly rebuilds docs needing extra
	# app-text/docbook-xml-dtd-{4.1.2,4.5} wtr bug 342743
	true
}

src_install() {
	gnome2_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "You can safely ignore any 'Unknown media type in type blah' warnings above."
	elog "For more info see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420795 "
}
