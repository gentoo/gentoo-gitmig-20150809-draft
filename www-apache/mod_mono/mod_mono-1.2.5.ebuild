# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.2.5.ebuild,v 1.1 2007/09/10 19:41:14 jurek Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="Apache module for Mono."
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
IUSE="aspnet2 debug"

DEPEND=">=dev-dotnet/xsp-${PV}"
RDEPEND="${DEPEND}"

APACHE1_MOD_FILE="${S}/src/.libs/${PN}.so"
APACHE1_MOD_CONF="${PV}/70_${PN}"
APACHE1_MOD_DEFINE="MONO"

APACHE2_MOD_FILE="${S}/src/.libs/${PN}.so"
APACHE2_MOD_CONF="${PV}/70_${PN}"
APACHE2_MOD_DEFINE="MONO"

DOCFILES="AUTHORS ChangeLog COPYING INSTALL NEWS README"

need_apache

src_unpack() {
	unpack ${A}
	cd "${S}"

	use aspnet2 && epatch "${FILESDIR}/mono_auto_application_aspnet2.patch"
}

src_compile() {
	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	mv -f "src/.libs/${PN}.so.0.0.0" "src/.libs/${PN}.so"
	apache-module_src_install
	doman man/mod_mono.8
}

pkg_postinst() {
	apache-module_pkg_postinst

	elog "To enable mod_mono, add \"-D MONO\" to your Apache's"
	elog "conf.d configuration file. Additionally, to view sample"
	elog "ASP.NET applications, add \"-D MONO_DEMO\" too."
	elog ""
	elog "If you want mod_mono to handle AutoHosting requests using"
	elog "ASP.NET 2.0 engine, enable the aspnet2 USE flag."
}
