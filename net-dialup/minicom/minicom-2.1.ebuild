# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.1.ebuild,v 1.9 2004/11/07 10:43:16 mrness Exp $

DESCRIPTION="Serial Communication Program"
SRC_URI="http://alioth.debian.org/download.php/123/${P}.tar.gz"
HOMEPAGE="http://alioth.debian.org/projects/minicom"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~hppa ~sparc ~mips amd64"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2-r3"
RDEPEND="${DEPEND}
	net-misc/lrzsz"

src_compile() {
	econf --sysconfdir=/etc/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc doc/minicom.FAQ
	insinto /etc/minicom
	doins ${FILESDIR}/minirc.dfl

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
