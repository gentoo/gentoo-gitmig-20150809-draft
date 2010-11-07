# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/luajit/luajit-2.0.0_beta5-r1.ebuild,v 1.1 2010/11/07 02:51:01 rafaelmartins Exp $

EAPI="2"

inherit eutils multilib pax-utils

MY_P="LuaJIT-${PV/_/-}"

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="http://luajit.org/"
SRC_URI="http://luajit.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare(){
	# fixing prefix and version
	sed -i -e "s|/usr/local|/usr|" \
		-e "s|/lib|/$(get_libdir)|" \
		-e "s|VERSION=.*|VERSION= ${PV}|" \
		Makefile || die "failed to fix prefix in Makefile"
	sed -i -e 's|/usr/local|/usr|' \
		-e "s|lib/|$(get_libdir)/|" \
		src/luaconf.h || die "failed to fix prefix in luaconf.h"

	# removing strip
	sed -i -e '/$(Q)$(TARGET_STRIP)/d' src/Makefile \
		|| die "failed to remove forced strip"

	# hotfix from upstream, just for this version (2.0.0_beta5)
	epatch "${FILESDIR}/${PV}_hotfix1.patch"
}

src_install(){
	einstall DESTDIR="${D}"
	pax-mark m "${D}usr/bin/luajit-${PV}"
	dosym "luajit-${PV}" "/usr/bin/luajit-${SLOT}"
}
