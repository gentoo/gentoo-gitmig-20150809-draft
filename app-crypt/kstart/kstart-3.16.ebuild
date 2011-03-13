# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kstart/kstart-3.16.ebuild,v 1.1 2011/03/13 04:15:28 eras Exp $

EAPI="2"

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

src_configure() {
	econf \
		--disable-k4start \
		--enable-reduced-depends \
		"$(use_with afs)" \
		"$(use_with afs aklog)" \
		"$(use_enable afs setpag)"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	doman k5start.1 krenew.1 || die
	dodoc README NEWS TODO || die
}
