# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zthread/zthread-2.3.1.ebuild,v 1.14 2010/04/16 17:52:57 ssuominen Exp $

inherit flag-o-matic

DESCRIPTION="a platform-independent object-oriented threading architecture"
HOMEPAGE="http://www.cs.buffalo.edu/~crahen/projects/zthread/"
SRC_URI="mirror://sourceforge/zthread/ZThread-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc alpha ~mips ~hppa amd64"
IUSE="debug"

S=${WORKDIR}/ZThread-${PV}

src_compile() {
	local myconf=""
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	append-flags -fpermissive

	econf ${myconf}
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README* NEWS TODO THANK.YOU
}
