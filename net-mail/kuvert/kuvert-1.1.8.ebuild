# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/kuvert/kuvert-1.1.8.ebuild,v 1.4 2004/11/30 22:20:40 swegener Exp $

inherit eutils

MY_P=${P/-/_}

DESCRIPTION="An MTA wrapper that automatically signs and/or encrypts
outgoing mail"
HOMEPAGE="http://www.snafu.priv.at/mystuff/kuvert/"
SRC_URI="http://www.snafu.priv.at/mystuff/kuvert/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc"
IUSE=""
SLOT="0"

DEPEND=">=app-crypt/gnupg-1.0.6
	app-crypt/quintuple-agent
	dev-perl/MailTools
	dev-perl/MIME-tools
	dev-perl/TermReadKey
	dev-lang/perl
	virtual/mta
	virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-idea.patch || die "epatch failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc dot-kuvert README THANKS TODO
}
