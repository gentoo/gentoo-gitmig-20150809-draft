# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zthread/zthread-2.2.10.ebuild,v 1.1 2003/01/12 18:12:10 vapier Exp $

DESCRIPTION="A Platform-Independent Object-Oriented Threading Architecture"
SRC_URI="mirror://sourceforge/zthread/ZThread-${PV}.tar.gz"
HOMEPAGE="http://www.cs.buffalo.edu/~crahen/projects/zthread/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE="pic"

DEPEND="virtual/glibc"

S=${WORKDIR}/ZThread-${PV}

src_compile() {
	local myconf="`use_with pic` --with-gnu-ld"
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
