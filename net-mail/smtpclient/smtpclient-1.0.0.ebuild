# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/smtpclient/smtpclient-1.0.0.ebuild,v 1.2 2003/02/13 14:40:21 vapier Exp $

IUSE=""

DESCRIPTION="Minimal SMTP client"
HOMEPAGE="http://www.engelschall.com/sw/smtpclient/"
SRC_URI="http://www.engelschall.com/sw/smtpclient/distrib/smtpclient-1.0.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	dobin smtpclient

	doman smtpclient.1

}
