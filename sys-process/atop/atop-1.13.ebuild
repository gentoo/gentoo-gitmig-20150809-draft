# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/atop/atop-1.13.ebuild,v 1.2 2005/04/23 07:07:35 vapier Exp $

ATOP_INIT_VERSION="1.9"
ATOP_INIT_SCRIPT=${PN}-${ATOP_INIT_VERSION}-initscript

DESCRIPTION="Resource-specific view of processes"
SRC_URI="ftp://ftp.atcomputing.nl/pub/tools/linux/${P}.tar.gz
	mirror://gentoo/${PN}-${ATOP_INIT_VERSION}-initscript"
HOMEPAGE="http://freshmeat.net/releases/112061/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-process/acct"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv "${S}"/atop.init "${S}"/atop.init.old
	cp "${DISTDIR}/${ATOP_INIT_SCRIPT}" "${S}"/atop.init
	chmod a+rx atop.init
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" INIPATH=/etc/init.d install || die
	dodoc README
}
