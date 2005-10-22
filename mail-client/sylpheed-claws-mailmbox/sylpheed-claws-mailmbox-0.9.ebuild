# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-mailmbox/sylpheed-claws-mailmbox-0.9.ebuild,v 1.7 2005/10/22 13:13:06 genone Exp $

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to operate on mbox type mailboxes"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://claws.sylpheed.org/downloads/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-0.9.12b-r1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS} -I/usr/include/gtk-1.2" || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
