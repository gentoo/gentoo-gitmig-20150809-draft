# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/t-prot/t-prot-1.48.ebuild,v 1.1 2005/01/04 09:19:31 tove Exp $

inherit eutils

DESCRIPTION="TOFU protection - display filter for RFC822 messages"
HOMEPAGE="http://www.escape.de/users/tolot/mutt/"
SRC_URI="http://www.escape.de/users/tolot/mutt/t-prot/downloads/${P}.tar.gz"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-lang/perl
	dev-perl/Getopt-Mixed"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${S}/contrib/t-prot-r1.???-mutt156.diff
}

src_install() {
	dobin t-prot
	doman t-prot.1
	dodoc BUGS ChangeLog README TODO
	docinto contrib
	dodoc contrib/{README.examples,muttrc.t-prot,t-prot.sl,filter_innd.pl}
}
