# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-01.00.ebuild,v 1.4 2004/01/05 02:18:33 vapier Exp $

MY_P="${P/-/-A.}"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	chmod a+r ${S}/lshw.1
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
