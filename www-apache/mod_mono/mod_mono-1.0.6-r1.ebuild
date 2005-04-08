# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_mono/mod_mono-1.0.6-r1.ebuild,v 1.3 2005/04/08 22:34:15 trapni Exp $

inherit apache-module

DESCRIPTION="Apache module for Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/xsp-${PV}"

APACHE1_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE1_MOD_CONF="1.0.5-r1/70_mod_mono"
APACHE1_MOD_DEFINE="MONO"

APACHE2_MOD_FILE="${S}/src/.libs/mod_mono.so"
APACHE2_MOD_CONF="1.0.5-r1/70_mod_mono"
APACHE2_MOD_DEFINE="MONO"

DOCFILES="AUTHORS ChangeLog COPYING INSTALL NEWS README"

need_apache

pkg_setup() {
	ewarn "Some users are experiencing problems with mod_mono, where mod-mono-server"
	ewarn "will not start automatically, or requests will get a HTTP 500 application"
	ewarn "error.  If you experience these problems, please report it on:"
	ewarn
	ewarn "  http://bugs.gentoo.org/show_bug.cgi?id=77169"
	ewarn
	ewarn "with as much information as possible.  Thanks!"
}

src_compile() {
	local apxs
	useq apache2 && apxs="${APXS2}"
	useq apache2 || apxs="${APXS1}"

	econf \
		--with-apxs=${apxs} \
		--with-apr-config=/usr/bin/apr-config || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	mv src/.libs/mod_mono.so{.0.0.0,}
	apache-module_src_install
	doman man/mod_mono.8
}

pkg_postinst() {
	apache-module_pkg_postinst

	einfo "To view the samples, add \"-D MONO_DEMO\" at your apache's"
	einfo "conf.d configuration file."
}
