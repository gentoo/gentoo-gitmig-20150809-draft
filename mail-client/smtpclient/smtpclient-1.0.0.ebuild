# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/smtpclient/smtpclient-1.0.0.ebuild,v 1.8 2009/08/01 01:10:25 vostorga Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="Minimal SMTP client"
HOMEPAGE="http://www.engelschall.com/sw/smtpclient/"
SRC_URI="http://www.engelschall.com/sw/smtpclient/distrib/smtpclient-1.0.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

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
