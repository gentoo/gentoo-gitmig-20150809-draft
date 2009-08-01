# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/smtpclient/smtpclient-1.0.1.ebuild,v 1.6 2009/08/01 06:13:37 mr_bones_ Exp $

inherit eutils

IUSE=""

DESCRIPTION="Minimal SMTP client"
HOMEPAGE="http://www.engelschall.com/sw/smtpclient/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""
RDEPEND=""

src_compile() {
	econf
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	dobin smtpclient
	doman smtpclient.1
}
