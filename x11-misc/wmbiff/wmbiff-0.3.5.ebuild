# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmbiff/wmbiff-0.3.5.ebuild,v 1.2 2002/05/27 17:27:40 drobbins Exp $

S=${WORKDIR}/${P}/wmbiff

DESCRIPTION=""
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"
DEPEND="virtual/glibc x11-base/xfree"
#RDEPEND=""

src_compile() {
	# disabling crypt for now, until I have time to
	# spend.
	mv Makefile Makefile.orig
	grep -v TLS Makefile.orig | grep -v gnutls > Makefile
	emake || die
}

src_install () {
	dobin wmbiff
	doman wmbiff.1 wmbiffrc.5
	cd ..
	dodoc ChangeLog  NEWS  README  README.licq  TODO
}
