# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smbget/smbget-0.6.ebuild,v 1.7 2006/11/22 02:48:16 beandog Exp $

DESCRIPTION="a simple wget-like tool for the SMB/CIFS protocol"
HOMEPAGE="http://jelmer.vernstok.nl/oss/smbget/"
SRC_URI="http://jelmer.vernstok.nl/oss/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

DEPEND="<net-fs/samba-3.0.20
	dev-libs/popt"

src_compile() {
	emake || die
}

src_install() {
	dobin smbget || die
	doman smbget.1 smbgetrc.5
	dodoc AUTHORS ChangeLog README TODO smbgetrc
}
