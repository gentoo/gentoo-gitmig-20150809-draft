# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_transform/mod_transform-0.7.0_pre20070204.ebuild,v 1.1 2007/08/20 23:23:06 hollow Exp $

inherit apache-module

DESCRIPTION="Filter module that allows Apache2 to do dynamic XSL transformations."
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_transform/"
SRC_URI="http://upstream.rm-rf.in/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/libxslt-1.1.5
		>=dev-libs/libxml2-2.6.11
		>=www-apache/libapreq2-2.07
		>=www-apache/mod_depends-0.7.0_p200702041"

RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="0.7/10_${PN}"
APACHE2_MOD_DEFINE="TRANSFORM"

need_apache2

src_compile() {
	econf --with-apxs=${APXS2} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# install header(s)
	local AP_INCLUDEDIR=$(${APXS2} -q INCLUDEDIR)
	insinto ${AP_INCLUDEDIR}
	doins include/mod_transform.h || die

	# install plugin(s)
	local PLUGIN_DIR=/usr/$(get_libdir)/apache2/modules/mod_transform
	dodir ${PLUGIN_DIR}
	insinto ${PLUGIN_DIR}
	doins src/.libs/http.so

	apache2_src_install
}
