# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qemacs/qemacs-0.3.1.ebuild,v 1.1 2003/05/11 09:38:19 mkennedy Exp $

DESCRIPTION="QEmacs (for Quick Emacs) is a very small but powerful UNIX editor."
HOMEPAGE="http://fabrice.bellard.free.fr/qemacs/"
SRC_URI="http://fabrice.bellard.free.fr/qemacs/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="X? ( virtual/x11 )
	png? ( =media-libs/libpng-1.2* )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/qemacs-Makefile-gentoo.patch || die
}

src_compile() {
	local myconf
	use X && myconf="--enable-x11" || myconf="--disable-x11"
	use png && myconf="${myconf} --enable-png" || myconf="${myconf} --disable-png"
	./configure ${myconf}
	emake || die
}

src_install() {
	dodir /usr/bin
	make prefix=${D}/usr \
		install || die
	doman qe.1
	dodoc COPYING Changelog README TODO VERSION
	dohtml *.html
}
