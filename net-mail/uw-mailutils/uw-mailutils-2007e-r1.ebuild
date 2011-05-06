# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/uw-mailutils/uw-mailutils-2007e-r1.ebuild,v 1.1 2011/05/06 21:00:09 eras Exp $

inherit eutils flag-o-matic

MY_P="imap-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Mail utilities from the UW"
HOMEPAGE="http://www.washington.edu/imap/"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="pam ssl"

DEPEND="!<mail-client/pine-4.64-r1
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	!<net-mail/uw-imap-${PV}"

src_unpack() {
	unpack ${A}
	chmod -R ug+w "${S}"

	cd "${S}"

	epatch "${FILESDIR}/${PN}-2004g.patch" || die "epatch failed"
	epatch "${FILESDIR}/${PN}-ssl.patch" || die "epatch failed"

	sed -i -e "s|\`cat \$C/CFLAGS\`|${CFLAGS}|g" \
		src/mailutil/Makefile \
		src/mtest/Makefile || die "sed failed patching Makefile CFLAGS."

	append-flags -fPIC
}

src_compile() {
	local port=slx
	use elibc_FreeBSD && port=bsf
	use pam && port=lnp
	local ssltype=none
	use ssl && ssltype=nopwd
	yes | make "${port}" EXTRACFLAGS="${CFLAGS}" SSLTYPE="${ssltype}" || die
}

src_install() {
	into /usr
	dobin mailutil/mailutil mtest/mtest
	doman src/mailutil/mailutil.1
}
