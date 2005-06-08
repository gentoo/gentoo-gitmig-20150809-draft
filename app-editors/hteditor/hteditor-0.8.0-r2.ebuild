# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-0.8.0-r2.ebuild,v 1.4 2005/06/08 11:58:26 dragonheart Exp $

inherit eutils

DESCRIPTION="editor for executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/ht-${PV}.tar.bz2
	mirror://gentoo/hteditor-${PV}-cvsupdates.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~amd64"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/ht-${PV/_/}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/hteditor-${PV}-cvsupdates
}

src_compile() {
	econf || die
	emake \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS KNOWNBUGS TODO README
	dohtml doc/ht.html
	doinfo doc/*.info
}
