# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdockapp/libdockapp-0.4.0-r1.ebuild,v 1.1 2002/10/08 12:56:11 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Window Maker Dock Applet Library"
SRC_URI="http://www.minet.uni-jena.de/~topical/sveng/wmail/${P}.tar.gz"
HOMEPAGE="http://www.minet.uni-jena.de/~topical/sveng/wmail.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=x11-base/xfree-4.1.0"
RDEPEND="${DEPEND}"

src_compile() {

	libtoolize --force --copy
	aclocal
	autoconf

	econf || die "configure failed"

	patch -p1 < ${FILESDIR}/${P}-r1-gentoo.diff \
		|| die "patch failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

	dodoc README ChangeLog NEWS AUTHORS

}

