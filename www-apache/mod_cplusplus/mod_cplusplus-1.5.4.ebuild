# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_cplusplus/mod_cplusplus-1.5.4.ebuild,v 1.4 2012/10/16 03:01:56 patrick Exp $

inherit apache-module autotools

DESCRIPTION="Easily implement object oriented apache-2.0 handlers with C++"
HOMEPAGE="http://modcplusplus.sourceforge.net/"
SRC_URI="mirror://sourceforge/modcplusplus/${P}.tar.gz"

LICENSE="BSD"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""

APACHE2_MOD_CONF="51_${PN}"
APACHE2_MOD_DEFINE="CPLUSPLUS"

DOCFILES="README"

need_apache2_2

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's/-Werror //g' configure.in
	eautoreconf
}

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	insinto /usr/include/apache2
	doins "${S}"/include/*.h
	mv "${S}"/src/.libs/{libmod_cplusplus-1.1.0,mod_cplusplus}.so
	apache-module_src_install
}
