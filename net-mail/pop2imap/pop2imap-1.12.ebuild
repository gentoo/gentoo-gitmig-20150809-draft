# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pop2imap/pop2imap-1.12.ebuild,v 1.2 2006/05/10 20:50:09 ferdy Exp $

DESCRIPTION="Synchronize mailboxes between a pop and an imap servers"
HOMEPAGE="http://www.linux-france.org/prj/pop2imap/"
SRC_URI="http://www.linux-france.org/prj/pop2imap/dist/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/Mail-POP3Client
	dev-perl/Mail-IMAPClient"

src_install(){
	dobin pop2imap
	dodoc ChangeLog README VERSION
}
