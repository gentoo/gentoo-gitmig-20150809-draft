# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: David Leal <david@l8f.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.5 2002/04/29 22:56:53 sandymac Exp

S=${WORKDIR}/${P}
DESCRIPTION="XMMS-Shell is a simple utility to control XMMS externally."
SRC_URI="http://download.sourceforge.net/xmms-shell/xmms-shell-0.99.0.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"
LICENSE="GPL"
DEPEND=">=media-sound/xmms-1.2.7
		readline? ( >=sys-libs/readline-4.1 )"

src_compile() {
	local myopts

	use readline \
		&& myopts="${myopts} --with-readline" \
		|| myopts="${myopts} --without-readline"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myopts} || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README
}
