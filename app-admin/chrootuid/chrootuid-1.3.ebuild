# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrootuid/chrootuid-1.3.ebuild,v 1.9 2006/04/25 16:16:31 lu_zero Exp $

IUSE=""

MY_P="${P/-/}"

DESCRIPTION="run a network service at low privilege level and with restricted file system access"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
DEPEND=">=sys-apps/sed-4"

LICENSE="BSD"
KEYWORDS="amd64 ppc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	# Add in our own custom CFLAGS
	sed -i "s/CFLAGS\t=/CFLAGS = ${CFLAGS} #/" Makefile
	emake || die "emake failed :'("
}

src_install() {
	dobin chrootuid
	doman chrootuid.1
	dodoc README chrootuid_license
}
