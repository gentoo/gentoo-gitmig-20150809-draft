# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-ringmgr/gpg-ringmgr-1.12.ebuild,v 1.4 2003/09/06 22:15:09 msterret Exp $

DESCRIPTION="GPG Keyring Manager to handle large GPG keyrings more easily"
HOMEPAGE="http://www.ualberta.ca/~rbpark/gpg-ringmgr.html"
SRC_URI="http://www.ualberta.ca/~rbpark/projects/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa"

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
