# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.3.5.ebuild,v 1.3 2003/09/06 05:56:25 msterret Exp $

S=${WORKDIR}/${P}/wmbiff
DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

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
