# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover/discover-2.0.1.ebuild,v 1.1 2003/09/18 17:24:59 seemant Exp $

IUSE="pcmcia"

S=${WORKDIR}/${P}
DESCRIPTION="Library and front-end for retrieving information about a system's hardware."
HOMEPAGE="http://hackers.progeny.com/${PN}/"
SRC_URI="http://archive.progeny.com/progeny/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="virtual/linux-sources
	net-ftp/curl
	dev-libs/expat"

PDEPEND="sys-apps/discover-data"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc-3.3.patch
}

src_compile() {
	local myconf=""

	use pcmcia \
		&& myconf="${myconf} --with-pcmcia-headers=/usr/src/linux/include"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS INSTALL LICENSE README RELEASE
}
