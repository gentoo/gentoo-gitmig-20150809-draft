# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-ghostscript-viewer/sylpheed-claws-ghostscript-viewer-0.8.ebuild,v 1.9 2005/03/29 18:27:37 corsair Exp $

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to view pdf and postscript attachments inline"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha ~ppc64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-0.9.12b-r1
		app-text/ghostscript"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
