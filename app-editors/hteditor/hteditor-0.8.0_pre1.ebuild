# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-0.8.0_pre1.ebuild,v 1.3 2004/06/27 22:13:51 vapier Exp $

DESCRIPTION="editor for executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/ht-${PV/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -alpha"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/ht-${PV/_/}"

src_compile() {
	chmod +x configure
	local myconf="--prefix=/usr --sysconfdir=/etc"
	./configure ${myconf}  || die
	emake "CC=${CC}" CXX=${CXX} "CFLAGS=${CFLAGS}" \
		"CXXFLAGS=${CXXFLAGS}" "LDFLAGS=${LDFLAGS}"|| die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS KNOWNBUGS TODO README
	dohtml doc/ht.html
	doinfo doc/*.info
}
