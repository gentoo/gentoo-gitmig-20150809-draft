# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/scsh/scsh-0.6.1-r1.ebuild,v 1.16 2004/11/07 09:21:39 mr_bones_ Exp $

DESCRIPTION="Unix shell embedded in Scheme"
HOMEPAGE="http://www.scsh.net/"
SRC_URI="ftp://ftp.scsh.net/pub/scsh/0.6/${P}.tar.gz"

LICENSE="|| ( as-is BSD GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf --prefix=/ \
		--libdir=/usr/lib \
		--includedir=/usr/include \
		|| die
	make || die
}

src_install() {
	einstall \
		prefix=${D} \
		htmldir=${D}/usr/share/doc/${PF}/html \
		incdir=${D}/usr/include \
		mandir=${D}/usr/share/man/man1 \
		libdir=${D}/usr/lib \
		|| die
	dodoc RELEASE

	# Scsh doesn't have a very consistent documentation
	# structure. It's possible to override the placement of the
	# HTML during make install, but not the other documentation in
	# TeX, DVI and PS formats.

	# Thus we let scsh install the documentation and then clean up
	# afterwards.

	dosed "s:${D}::" /usr/share/man/man1/scsh.1

	dodir /usr/share/doc/${PF}
	mv ${D}/usr/lib/scsh/doc/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/lib/scsh/doc
	prepalldocs
}
