# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-ringmgr/gpg-ringmgr-1.12.ebuild,v 1.2 2003/06/29 22:18:39 aliz Exp $

DESCRIPTION="GPG Keyring Manager to handle large GPG keyrings more easily"

HOMEPAGE="http://www.ualberta.ca/~rbpark/gpg-ringmgr.html"

SRC_URI="http://www.ualberta.ca/~rbpark/projects/${PN}"

LICENSE="GPL-2"

SLOT="0"

#This should work everywhere
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa"

DEPEND="dev-lang/perl
		>=app-crypt/gnupg-1.2.1"

RDEPEND="${DEPEND}"

IUSE=""

S=${WORKDIR}/${P}

src_unpack() {
    cd ${WORKDIR} && mkdir ${P}
	cp ${DISTDIR}/${PN} ${S}
}

src_compile() {
	pod2man ${S}/${PN} >${S}/${PN}.1
	pod2html ${S}/${PN} >${S}/${PN}.html
}

src_install() {
	# base install
	dobin ${PN}
	# now we all all the docs
	doman ${PN}.1 
	dohtml ${PN}.html
	# prepalldocs rocks! I saw it in net-fs/samba/samba-2.2.8
	prepalldocs
}
