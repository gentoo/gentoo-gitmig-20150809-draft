# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rng-tools/rng-tools-2-r3.ebuild,v 1.1 2010/09/15 08:30:51 robbat2 Exp $

EAPI=2
inherit autotools

DESCRIPTION="Daemon to use hardware random number generators."
HOMEPAGE="http://gkernel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/rngd_tpm_support2.patch

	echo 'bin_PROGRAMS = randstat' >> contrib/Makefile.am
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog
	doinitd "${FILESDIR}/2-r2/rngd"
	newconfd "${FILESDIR}/2-r2/rngd-conf" rngd
}
