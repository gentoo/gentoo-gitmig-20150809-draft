# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ginac/ginac-1.2.3.ebuild,v 1.2 2004/10/05 02:17:31 weeve Exp $

IUSE=""

inherit flag-o-matic

Name="GiNaC"
S=${WORKDIR}/${Name}-${PV}

DESCRIPTION="GiNaC : a free CAS (computer algebra system)"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${Name}-${PV}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="dev-libs/cln"

src_compile() {
	filter-flags "-funroll-loops -frerun-loop-opt"
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
