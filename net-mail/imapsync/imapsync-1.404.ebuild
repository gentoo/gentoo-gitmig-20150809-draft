# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.404.ebuild,v 1.1 2011/03/07 20:10:30 tove Exp $

EAPI=3

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another"
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}-sources.tgz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
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
