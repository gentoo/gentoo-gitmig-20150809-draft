# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-01.00.ebuild,v 1.1 2003/04/15 15:15:46 mholzer Exp $

MY_P="${P/-/-A.}"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${MY_P}.tar.gz || die
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

