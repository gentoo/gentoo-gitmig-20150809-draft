# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.6.2.ebuild,v 1.2 2007/07/14 22:22:19 mr_bones_ Exp $

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.0"

src_install() {
	# braindead setup.py, so just install the old-fashioned way
	newbin archivemail.py archivemail
	doman ${FILESDIR}/archivemail.1
	dodoc examples/* CHANGELOG FAQ README TODO
}
