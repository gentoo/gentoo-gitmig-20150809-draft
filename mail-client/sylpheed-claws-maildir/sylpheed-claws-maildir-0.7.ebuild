# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-maildir/sylpheed-claws-maildir-0.7.ebuild,v 1.6 2005/03/29 18:25:59 corsair Exp $

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to operate on maildir type mailboxes"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha ~ppc64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-0.9.13"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
