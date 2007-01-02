# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.1.17-r1.ebuild,v 1.2 2007/01/02 22:41:48 jurek Exp $

inherit apache-module eutils

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug aspnet2"
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

src_unpack()
{
	unpack ${A}
	cd ${S}

	use aspnet2 && epatch ${FILESDIR}/mono_auto_application_aspnet2.patch
}

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

	elog "To enable mod_mono, add \"-D MONO\" to your apache's"
	elog "conf.d configuration file. Additionally, to view sample"
	elog "ASP.NET applications, add \"-D MONO_DEMO\" too."
	elog ""
	elog "If you want mod_mono to handle AutoHosting requests using"
	elog "ASP.NET 2.0 engine, enable the aspnet2 USE flag"
}
