# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-maildir/sylpheed-claws-maildir-0.6.ebuild,v 1.5 2004/11/03 19:06:52 genone Exp $

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to operate on maildir type mailboxes"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-0.9.12b-r1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# patch broken Makefile
	sed -i -e 's:\$(libdir)/sylpheed/plugins:\$(SYLPHEED_CLAWS_PLUGINDIR):' src/Makefile.in

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
