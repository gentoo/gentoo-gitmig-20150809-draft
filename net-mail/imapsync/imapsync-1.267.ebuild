# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.267.ebuild,v 1.2 2009/06/17 20:21:15 fauli Exp $

inherit eutils

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another."
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="http://www.linux-france.org/prj/imapsync/dist/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	virtual/perl-Digest-MD5
	dev-perl/DateManip
	dev-perl/Net-SSLeay
	virtual/perl-MIME-Base64
	dev-perl/TermReadKey
	dev-perl/IO-Socket-SSL
	dev-perl/Digest-HMAC
	=dev-perl/Mail-IMAPClient-2.2.9"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	sed -i -e "s/^install: testp/install:/" \
		-e "s/^\(all: ChangeLog README\) VERSION/\1/" "${S}"/Makefile || die
}

src_compile() {
	emake all || die
}

src_install() {
	make DESTDIR="${D}" install || die "make failed"
	dodoc CREDITS ChangeLog FAQ README TODO || die "dodoc failed"
}
