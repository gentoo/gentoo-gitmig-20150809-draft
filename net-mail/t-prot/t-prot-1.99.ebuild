# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/t-prot/t-prot-1.99.ebuild,v 1.1 2005/03/25 02:10:10 tove Exp $

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

	if has_version '>=mail-client/mutt-1.5.7' ; then
		epatch ${S}/contrib/t-prot-r1.*-mutt157.diff
	fi

	if has_version '<=app-crypt/gnupg-1.2.6' ; then
		epatch ${S}/contrib/t-prot-r1.*-gpg126.diff
	fi
}

src_install() {
	dobin t-prot || die "dobin failed."
	doman t-prot.1 || die "doman failed."
	dodoc BUGS ChangeLog README TODO || die "dodoc failed."
	docinto contrib
	dodoc contrib/{README.examples,muttrc.t-prot,t-prot.sl,filter_innd.pl} \
		|| die "dodoc contrib failed"
}
