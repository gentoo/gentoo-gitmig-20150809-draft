# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cppserv/cppserv-0.1.113.ebuild,v 1.1 2008/06/27 18:20:50 iluxa Exp $

inherit eutils apache-module

DESCRIPTION="CPPSERV is an application server providing Servlet-like API in C++ and a C++ Server Pages parser."
HOMEPAGE="http://www.total-knowledge.com/progs/cppserv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~x86 ~mips ~amd64"
IUSE="debug"

APACHE2_MOD_CONF="75_mod_cserv"
APACHE2_MOD_DEFINE="CPPSERV"

DEPEND="net-libs/socket++
	>=dev-cpp/sptk-3.5.6
	>=www-servers/apache-2
	>=dev-libs/apr-1.2
	dev-libs/boost
"

need_apache2

src_compile() {
	local CPPSERV_DBG_FLAG
	use debug && CPPSERV_DBG_FLAG="CPPFLAGS=-DMODCSERV_DEBUG"
	emake PREFIX=/usr ADON_VERBOSE=1 ADON_BUILD=release APRCFG_PATH=/usr/bin/apr-1-config ${CPPSERV_DBG_FLAG} || die "emake failed. Bug iluxa on #cppserv on irc.freenode.net immediately"
}

src_install() {
	local CPPSERV_DBG_FLAG
	use debug && CPPSERV_DBG_FLAG="CPPFLAGS=-DMODCSERV_DEBUG"
	emake PREFIX=/usr ADON_BUILD=release APRCFG_PATH=/usr/bin/apr-1-config DESTDIR="${D}" ${CPPSERV_DBG_FLAG} install || die "emake install failed. Bug iluxa on #cppserv on irc.freenode.net immediately"
	insinto "${APACHE_MODULES_CONFDIR}"
	doins "${FILESDIR}/${APACHE2_MOD_CONF}.conf" || die "internal ebuild error: \"${FILESDIR}/${APACHE2_MOD_CONF}.conf\" not found. Bug iluxa on #cppserv on irc.freenode.net immediately"
}
