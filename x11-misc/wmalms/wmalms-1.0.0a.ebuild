# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmalms/wmalms-1.0.0a.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

DESCRIPTION="wmalms X-windows hardware sensors applet"
DEPEND="x11-base/xfree"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${P}
SRC_URI="http://www.geocities.com/wmalms/wmalms-1.0.0a.tar.gz"
HOMEPAGE="http://www.geocities.com/wmalms"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc install
}
