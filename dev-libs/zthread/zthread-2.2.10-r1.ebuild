# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zthread/zthread-2.2.10-r1.ebuild,v 1.3 2003/08/03 02:27:17 vapier Exp $

DESCRIPTION="a platform-independent object-oriented threading architecture"
HOMEPAGE="http://www.cs.buffalo.edu/~crahen/projects/zthread/"
SRC_URI="mirror://sourceforge/zthread/ZThread-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~mips ~hppa"

DEPEND="virtual/glibc"

S=${WORKDIR}/ZThread-${PV}

src_compile() {
	local myconf=""
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO THANK.YOU
}
