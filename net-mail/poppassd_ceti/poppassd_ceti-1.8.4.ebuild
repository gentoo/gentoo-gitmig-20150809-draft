# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/poppassd_ceti/poppassd_ceti-1.8.4.ebuild,v 1.1 2005/01/11 06:38:42 cryos Exp $

inherit eutils toolchain-funcs

MY_PN="poppassd"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Password change daemon with PAM support"
HOMEPAGE="http://echelon.pl/pubs/poppassd.html"
SRC_URI="http://echelon.pl/pubs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cracklib"

DEPEND="virtual/libc
	>=sys-libs/pam-0.75-r8"

RDEPEND="${DEPEND}
	sys-apps/xinetd
	cracklib? ( sys-libs/cracklib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/poppassd_ceti-gcc-3.4.patch
}

src_compile() {
	$(tc-getCC) -c ${CFLAGS} ${MY_PN}.c || die "Compile failed."
	$(tc-getCC) -o poppassd ${MY_PN}.o -lpam -ldl || die "Linking failed."
}

src_install() {
	dodoc README

	insinto /etc/pam.d
	newins ${FILESDIR}/poppassd.pam poppassd
	use cracklib && sed -i -e 's|#password|password|' ${D}/etc/pam.d/poppassd

	insinto /etc/xinetd.d
	newins ${FILESDIR}/poppassd.xinetd poppassd

	insinto /usr/sbin
	insopts -o root -g bin -m 500
	doins poppassd || die "Install failed."
}

