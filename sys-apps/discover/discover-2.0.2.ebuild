# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover/discover-2.0.2.ebuild,v 1.1 2004/02/08 20:09:47 vapier Exp $

DESCRIPTION="Library and front-end for retrieving information about a system's hardware"
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="http://archive.progeny.com/progeny/discover/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"
IUSE="pcmcia"

DEPEND="pcmcia? ( virtual/linux-sources )
	net-ftp/curl
	dev-libs/expat"
PDEPEND="sys-apps/discover-data"

src_unpack() {
	unpack ${A}
	cd ${S}
	which docbook-to-man 2>/dev/null \
		|| sed -i 's:docbook-to-man:docbook2man:' doctools/docbook.mk
}

src_compile() {
	local myconf=""
	use pcmcia \
		&& myconf="--with-pcmcia-headers=/usr/src/linux/include"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README RELEASE
}
