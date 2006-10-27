# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.1.17.ebuild,v 1.1 2006/10/27 13:57:30 jurek Exp $

inherit apache-module

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="apache2 debug"
DEPEND=">=dev-dotnet/xsp-1.1.17"

RDEPEND="${DEPEND}"

APACHE1_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE1_MOD_CONF="${PV}/70_mod_mono"
APACHE1_MOD_DEFINE="MONO"

APACHE2_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE2_MOD_CONF="${PV}/70_mod_mono"
APACHE2_MOD_DEFINE="MONO"

DOCFILES="AUTHORS ChangeLog COPYING INSTALL NEWS README"

need_apache

src_compile() {
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
