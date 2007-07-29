# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppserv/cppserv-0.1.99.ebuild,v 1.2 2007/07/29 16:45:37 phreak Exp $

inherit eutils apache-module

DESCRIPTION="CPPSERV is an application server providing Servlet-like API in C++, as well as CSP (C++ Server Pages) parser."
HOMEPAGE="http://www.total-knowledge.com/progs/cppserv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~x86 ~mips ~amd64"
IUSE=""

APACHE2_MOD_CONF="75_${PN}.conf"

DEPEND="net-libs/socket++
	>=dev-cpp/sptk-3.4.1
	=www-servers/apache-2.0*
	dev-libs/boost
"

need_apache2

src_compile() {
	emake PREFIX=/usr ADON_BUILD=release || die "emake failed"
}

src_install() {
	emake PREFIX=/usr ADON_BUILD=release DESTDIR="${D}" install || die "emake install failed"
}
