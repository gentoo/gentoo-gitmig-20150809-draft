# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake-wrapper/automake-wrapper-3-r2.ebuild,v 1.1 2009/05/17 13:01:41 flameeyes Exp $

inherit multilib

DESCRIPTION="wrapper for automake to manage multiple automake versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}

src_compile() {
	sed -e 's:vers=":\0 1.11 :' \
		"${FILESDIR}"/am-wrapper-${PV}.sh \
		> "${T}"/am-wrapper.sh || die
}

src_install() {
	exeinto /usr/$(get_libdir)/misc
	doexe "${T}"/am-wrapper.sh || die

	keepdir /usr/share/aclocal

	dodir /usr/bin
	local x=
	for x in aclocal automake ; do
		dosym ../$(get_libdir)/misc/am-wrapper.sh /usr/bin/${x}
	done
}
