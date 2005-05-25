# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchyahoo/fetchyahoo-2.8.0.ebuild,v 1.5 2005/05/25 14:25:44 mcummings Exp $

IUSE=""
DESCRIPTION="Perl script that downloads mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
SRC_URI="http://fetchyahoo.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://fetchyahoo.twizzler.org/"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

SLOT="0"

DEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/MIME-tools
	dev-perl/libnet
	dev-perl/Crypt-SSLeay
	dev-perl/URI
	dev-perl/MailTools
	dev-perl/IO-stringy
	dev-perl/MIME-Base64"

src_install() {
	dobin fetchyahoo
	doman fetchyahoo.1
	insinto /etc
	doins fetchyahoorc
	dodoc COPYING ChangeLog Credits INSTALL TODO
	dohtml index.html
}

pkg_postinst() {
	einfo "Edit /etc/fetchyahoorc or ~/.fetchyahoorc to configure fetchyahoo"
	einfo "The executable name has changed from fetchyahoo.pl to fetchyahoo"
}
