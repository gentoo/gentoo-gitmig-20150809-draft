# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_transform/mod_transform-0.4.0.ebuild,v 1.3 2004/09/03 23:24:08 pvdabeel Exp $

DESCRIPTION="filter module that allows Apache 2.0 to do dynamic XSL Transformations"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_transform/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND=">=net-www/apache-2.0.40
	>=dev-libs/libxslt-1.0.22
	>=dev-libs/libxml2-2.6.6"

src_compile() {
	econf \
		--with-apxs=/usr/sbin/apxs2 \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	newexe src/.libs/libmod_transform.so.0.0.0 mod_transform.so

	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/mod_transform.conf

	dodoc TODO
}
