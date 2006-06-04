# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_transform/mod_transform-0.6.0.ebuild,v 1.7 2006/06/04 18:50:26 vericgar Exp $

inherit eutils apache-module

DESCRIPTION="Filter module that allows Apache 2.0 to do dynamic XSL Transformations"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_transform/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.1.5
	>=dev-libs/libxml2-2.6.11"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="TRANSFORM"

DOCFILES="TODO"

need_apache2

src_compile() {
	econf --with-apxs=${APXS2} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	mv src/.libs/{libmod_transform.so,mod_transform.so} || die
	apache2_src_install
}
