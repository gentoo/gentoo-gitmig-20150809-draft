# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imwheel/imwheel-1.0.0_pre2.ebuild,v 1.3 2003/12/12 20:46:14 aliz Exp $

DESCRIPTION="mouse tool for advanced features such as wheels and 3+ buttons"
HOMEPAGE="http://jcatki.dhs.org/imwheel/"
SRC_URI="http://jcatki.no-ip.org/imwheel/files/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${P/_/}"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die "patch failed"

}

src_compile() {

	local myconf

	# don't build gpm stuff
	myconf="--disable-gpm --disable-gpm-doc"

	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog EMACS M-BA47 NEWS README TODO

	dodir /etc/X11
	insinto /etc/X11
	doins imwheelrc

}
