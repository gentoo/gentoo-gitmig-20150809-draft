# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-ringmgr/gpg-ringmgr-1.12.ebuild,v 1.12 2004/11/21 04:25:43 kingtaco Exp $

DESCRIPTION="GPG Keyring Manager to handle large GPG keyrings more easily"
HOMEPAGE="http://www.ualberta.ca/~rbpark/gpg-ringmgr.html"
SRC_URI="http://www.ualberta.ca/~rbpark/projects/${PN}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc ~sparc alpha hppa ~amd64"

DEPEND="dev-lang/perl
	>=app-crypt/gnupg-1.2.1"

src_unpack() {
	mkdir ${P}
	cp ${DISTDIR}/${PN} ${S}
}

src_compile() {
	pod2man ${S}/${PN} >${S}/${PN}.1
	pod2html ${S}/${PN} >${S}/${PN}.html
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dohtml ${PN}.html
	prepalldocs
}
