# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrootuid/chrootuid-1.3-r1.ebuild,v 1.1 2010/10/11 09:59:53 hattya Exp $

EAPI="3"

inherit toolchain-funcs

IUSE=""

MY_P="${P/-/}"

DESCRIPTION="run a network service at low privilege level and with restricted file system access"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}" || die

}

src_install() {

	dobin chrootuid
	doman chrootuid.1
	dodoc README chrootuid_license

}
