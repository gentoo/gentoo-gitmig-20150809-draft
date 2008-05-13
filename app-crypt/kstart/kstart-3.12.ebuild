# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kstart/kstart-3.12.ebuild,v 1.2 2008/05/13 16:12:28 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Modified versions of kinit for automatic ticket refresh"
HOMEPAGE="http://www.eyrie.org/~eagle/software/kstart"
SRC_URI="http://archives.eyrie.org/software/kerberos/${P}.tar.gz"

LICENSE="|| ( MIT Stanford ISC )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="afs"

DEPEND="virtual/krb5"
RDEPEND="$DEPEND
	afs? ( net-fs/openafs )"

src_compile() {
	myconf="--disable-k4start \
		--with-kerberos \
		$(use_with afs afs /usr/bin/aklog)"
	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	emake -j1 check \
		|| die "Make test failed. See above for details."
}

src_install() {
	dobin k5start krenew
	doman k5start.1 krenew.1
	dodoc README NEWS || die
}
