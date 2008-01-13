# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppserv/cppserv-0.1.103.ebuild,v 1.1 2008/01/13 09:50:55 iluxa Exp $

inherit eutils apache-module

DESCRIPTION="CPPSERV is an application server providing Servlet-like API in C++, as well as CSP (C++ Server Pages) parser."
HOMEPAGE="http://www.total-knowledge.com/progs/cppserv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~x86 ~mips ~amd64"
IUSE=""

APACHE2_MOD_CONF="75_mod_cserv"

DEPEND="net-libs/socket++
	>=dev-cpp/sptk-3.5.6
	=www-servers/apache-2.0*
	dev-libs/boost
"

need_apache2

src_compile() {
	emake PREFIX=/usr ADON_VERBOSE=1 ADON_BUILD=release || die "emake failed"
}

src_install() {
	emake PREFIX=/usr ADON_BUILD=release DESTDIR="${D}" install || die "emake install failed"
	insinto "${APACHE2_MODULES_CONFDIR}"
	doins "${FILESDIR}/${APACHE2_MOD_CONF}.conf" || die "internal ebuild error: \"${FILESDIR}/${APACHE2_MOD_CONF}.conf\" not found"
}
