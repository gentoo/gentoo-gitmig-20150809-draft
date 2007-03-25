# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.182.ebuild,v 1.4 2007/03/25 14:44:54 dertobi123 Exp $

inherit eutils

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another."
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="http://www.linux-france.org/prj/imapsync/dist/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND=">=dev-perl/Mail-IMAPClient-2.1.4"

RDEPEND="${DEPEND}
	virtual/perl-Digest-MD5
	dev-perl/Net-SSLeay
	virtual/perl-MIME-Base64
	dev-perl/TermReadKey
	dev-perl/IO-Socket-SSL"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	make install DESTDIR=${D} || die "make failed"
	dobin imapsync

	dodoc CREDITS ChangeLog FAQ README TODO || \
		die "dodoc failed"

}
