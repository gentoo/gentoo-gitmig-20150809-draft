# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppserv/cppserv-0.1.98.ebuild,v 1.1 2006/11/20 16:52:54 iluxa Exp $

inherit eutils apache-module

DESCRIPTION="CPPSERV is an application server providing Servlet-like API in C++, as well as CSP (C++ Server Pages) parser."
HOMEPAGE="http://www.total-knowledge.com/progs/cppserv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~x86 ~mips ~amd64"
IUSE=""

DEPEND="net-libs/socket++
	>=dev-cpp/sptk-3.2.6
	=net-www/apache-2.0*
	dev-libs/boost
"

src_compile() {
	emake PREFIX=/usr ADON_BUILD=release || die "emake failed"
}

src_install() {
	emake PREFIX=/usr ADON_BUILD=release DESTDIR="${D}" install || die "emake install failed"
	insinto ${APACHE2_MODULES_CONFDIR}
	newins "${FILESDIR}/75_mod_cserv.conf" "75_mod_cserv.conf"
}
