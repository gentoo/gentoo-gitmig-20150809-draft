# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/videorbits/videorbits-2.201.ebuild,v 1.3 2003/07/12 16:44:48 aliz Exp $

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="a collection of programs for creating high dynamic range images."
SRC_URI="http://us.dl.sourceforge.net/comparametric/${P}.tgz"
HOMEPAGE="http://comparametric.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}/images
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/images:\$(prefix)/share/${PN}/images:" Makefile.in-orig > Makefile.in

	cd ${S}/lookuptables
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/lookuptables:\$(prefix)/share/${PN}/lookuptables:" Makefile.in-orig > Makefile.in
}

src_compile() {
	econf || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	# If the above installs anything outside of DESTDIR, try the following.
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die

	# Install documentation.
	dodoc AUTHORS ChangeLog COPYING NEWS README README.MORE
}
