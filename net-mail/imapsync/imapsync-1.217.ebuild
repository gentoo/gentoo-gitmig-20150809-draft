# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.217.ebuild,v 1.1 2007/04/01 17:51:53 ticho Exp $

inherit eutils

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another."
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="http://www.linux-france.org/prj/imapsync/dist/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-perl/Mail-IMAPClient-2.1.4"

RDEPEND="${DEPEND}
	virtual/perl-Digest-MD5
	dev-perl/Net-SSLeay
	virtual/perl-MIME-Base64
	dev-perl/TermReadKey
	dev-perl/IO-Socket-SSL"

RESTRICT="test"

src_install() {
	make DESTDIR="${D}" install || die "make failed"
	dodoc CREDITS ChangeLog FAQ README TODO || die "dodoc failed"
}
