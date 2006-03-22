# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/smtpclient/smtpclient-1.0.1.ebuild,v 1.3 2006/03/22 17:40:47 mr_bones_ Exp $

inherit eutils

IUSE="fullheaders"

DESCRIPTION="Minimal SMTP client"
HOMEPAGE="http://www.engelschall.com/sw/smtpclient/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""

src_install () {
	dobin smtpclient
	doman smtpclient.1
}
