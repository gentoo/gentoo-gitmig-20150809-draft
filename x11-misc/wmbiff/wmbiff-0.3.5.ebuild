# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmbiff/wmbiff-0.3.5.ebuild,v 1.6 2002/08/14 23:44:15 murphy Exp $

S=${WORKDIR}/${P}/wmbiff

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"
DEPEND="virtual/glibc x11-base/xfree"
#RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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
