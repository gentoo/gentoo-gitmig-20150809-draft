# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrootuid/chrootuid-1.3.ebuild,v 1.14 2008/10/26 15:54:06 hattya Exp $

inherit toolchain-funcs

IUSE=""

MY_P="${P/-/}"

DESCRIPTION="run a network service at low privilege level and with restricted file system access"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="amd64 arm ia64 ppc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die

}

src_install() {

	dobin chrootuid
	doman chrootuid.1
	dodoc README chrootuid_license

}
