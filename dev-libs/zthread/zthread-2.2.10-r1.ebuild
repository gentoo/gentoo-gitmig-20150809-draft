# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zthread/zthread-2.2.10-r1.ebuild,v 1.2 2003/07/12 09:22:23 aliz Exp $

DESCRIPTION="A Platform-Independent Object-Oriented Threading Architecture"
SRC_URI="mirror://sourceforge/zthread/ZThread-${PV}.tar.gz"
HOMEPAGE="http://www.cs.buffalo.edu/~crahen/projects/zthread/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~mips ~hppa"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/ZThread-${PV}

src_compile() {
	local myconf="--with-gnu-ld"
	[ "${DEBUGBUILD}" ] \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO THANK.YOU
}
