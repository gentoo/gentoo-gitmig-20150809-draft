# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchyahoo/fetchyahoo-2.14.0.ebuild,v 1.1 2010/11/17 22:41:04 radhermit Exp $

EAPI=3

DESCRIPTION="Download mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
HOMEPAGE="http://fetchyahoo.twizzler.org/"
SRC_URI="http://fetchyahoo.twizzler.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/MIME-tools
	virtual/perl-libnet
	dev-perl/Crypt-SSLeay
	dev-perl/URI
	dev-perl/MailTools
	dev-perl/IO-stringy
	virtual/perl-MIME-Base64
	dev-perl/TermReadKey"

src_install() {
	dobin fetchyahoo || die
	doman fetchyahoo.1 || die
	insinto /etc
	doins fetchyahoorc || die
	dodoc ChangeLog Credits INSTALL TODO fetchyahoorc || die
	dohtml index.html || die
}

pkg_postinst() {
	elog "Edit /etc/fetchyahoorc or ~/.fetchyahoorc to configure fetchyahoo"
	elog "The executable name has changed from fetchyahoo.pl to fetchyahoo"
}
