# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.1.13.5.ebuild,v 1.3 2007/01/02 22:41:48 jurek Exp $

inherit apache-module eutils versionator

MY_PV=$(get_version_component_range 1-3)

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"
DEPEND=">=dev-dotnet/xsp-${MY_PV}
		<dev-dotnet/xsp-1.1.17"

RDEPEND="${DEPEND}"

APACHE1_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE1_MOD_CONF="${MY_PV}/70_mod_mono"
APACHE1_MOD_DEFINE="MONO"

APACHE2_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE2_MOD_CONF="${MY_PV}/70_mod_mono"
APACHE2_MOD_DEFINE="MONO"

DOCFILES="AUTHORS ChangeLog COPYING INSTALL NEWS README"

need_apache

pkg_setup() {

	ewarn "Some users are experiencing problems with mod_mono, where mod-mono-server"
	ewarn "will not start automatically, or requests will get a HTTP 500 application"
	ewarn "error.  If you experience these problems, please report it on:"
	ewarn
	ewarn "http://bugs.gentoo.org/show_bug.cgi?id=77169"
	ewarn
	ewarn "with as much information as possible.  Thanks!"
}



src_compile() {
	epatch ${FILESDIR}/${P}-configure-apr-config.patch

	conf="$(use_enable debug) \
		  --disable-dependency-tracking"
	econf ${conf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	mv src/.libs/mod_mono.so{.0.0.0,}
	apache-module_src_install
	doman man/mod_mono.8
}

pkg_postinst() {
	apache-module_pkg_postinst

	einfo "To enable mod_mono, add \"-D MONO\" to your apache's"
	einfo "conf.d configuration file. Additionally, to view sample"
	einfo "ASP.NET applications, add \"-D MONO_DEMO\" too."
}
