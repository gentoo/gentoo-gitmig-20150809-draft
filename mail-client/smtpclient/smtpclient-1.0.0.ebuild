# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/smtpclient/smtpclient-1.0.0.ebuild,v 1.6 2006/03/18 21:39:42 eradicator Exp $

IUSE=""

DESCRIPTION="Minimal SMTP client"
HOMEPAGE="http://www.engelschall.com/sw/smtpclient/"
SRC_URI="http://www.engelschall.com/sw/smtpclient/distrib/smtpclient-1.0.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

DEPEND="virtual/libc"

src_install () {
	dobin smtpclient
	doman smtpclient.1
}
