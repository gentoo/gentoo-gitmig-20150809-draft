# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/t-prot/t-prot-2.4.ebuild,v 1.1 2007/03/21 07:09:36 tove Exp $

inherit eutils

DESCRIPTION="TOFU protection - display filter for RFC822 messages"
HOMEPAGE="http://www.escape.de/users/tolot/mutt/"
SRC_URI="http://www.escape.de/users/tolot/mutt/t-prot/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="dev-lang/perl
	dev-perl/Locale-gettext
	dev-perl/Getopt-Mixed"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${S}"/contrib/t-prot-r1.*-mutt*.diff
}

src_install() {
	dobin t-prot || die "dobin failed"
	doman t-prot.1 || die "doman failed"
	dodoc ChangeLog README TODO || die "dodoc failed"
	docinto contrib
	dodoc contrib/{README.examples,muttrc.t-prot,t-prot.sl*,filter_innd.pl} \
		|| die "dodoc contrib failed"
}
