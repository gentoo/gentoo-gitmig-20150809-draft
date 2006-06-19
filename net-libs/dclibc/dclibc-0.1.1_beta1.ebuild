# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dclibc/dclibc-0.1.1_beta1.ebuild,v 1.1 2006/06/19 06:49:43 squinky86 Exp $

inherit versionator

DESCRIPTION="library for creating a direct connect client"
HOMEPAGE="http://www.gtkdc.org/"

MY_PV=$(replace_version_separator 3 '-')
MY_PV=${MY_PV/beta/debug}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

SRC_URI="http://www.gtkdc.org/gtkdc_files/dclibc/0.1/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

DEPEND="virtual/libc"

src_compile() {
	econf $(use_enable static) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
