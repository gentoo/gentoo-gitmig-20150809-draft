# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchyahoo/fetchyahoo-2.13.7.ebuild,v 1.2 2010/11/03 02:02:19 jmbsvicetto Exp $

IUSE=""
DESCRIPTION="Download mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
MY_P=${P/_alpha/alpha}
SRC_URI="http://fetchyahoo.twizzler.org/${MY_P}.tar.gz"
HOMEPAGE="http://fetchyahoo.twizzler.org/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

S="${WORKDIR}/${MY_P}"

SLOT="0"

DEPEND="dev-lang/perl
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
RDEPEND="${DEPEND}"

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
