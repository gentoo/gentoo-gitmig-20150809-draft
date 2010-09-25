# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.350.ebuild,v 1.1 2010/09/25 08:06:49 radhermit Exp $

EAPI=2

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another."
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="http://www.linux-france.org/prj/imapsync/dist/${P}.tgz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/DateManip
	dev-perl/Digest-HMAC
	dev-perl/IO-Socket-SSL
	dev-perl/Mail-IMAPClient
	dev-perl/Net-SSLeay
	dev-perl/TermReadKey
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64"

RESTRICT="test"

src_prepare() {
	sed -i -e "s/^install: testp/install:/" "${S}"/Makefile || die
}

src_compile() { : ; }

src_install() {
	emake DESTDIR="${D}" install || die "make failed"
	dodoc CREDITS ChangeLog FAQ README TODO || die "dodoc failed"
}
