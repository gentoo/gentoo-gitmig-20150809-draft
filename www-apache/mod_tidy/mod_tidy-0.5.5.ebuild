# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_tidy/mod_tidy-0.5.5.ebuild,v 1.2 2008/01/31 19:25:34 hollow Exp $

inherit eutils apache-module

DESCRIPTION="a TidyLib based module to parse, clean-up and pretty-print the webservers' (X)HTML output"
SRC_URI="http://mod-tidy.sourceforge.net/src/${P}.tar.gz"
HOMEPAGE="http://mod-tidy.sourceforge.net/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"
IUSE=""

APACHE2_MOD_CONF="55_${PN}"
APACHE2_MOD_DEFINE="TIDY"

DEPEND="app-text/htmltidy"
RDEPEND="${DEPEND}"

need_apache2

DOCFILES="Changes INSTALL LICENSE README"

src_compile() {
	econf --with-apxs=${APXS} || die "configure failed"
	emake || die "make failed"
}

# vim:ts=4
