# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capisuite/capisuite-0.4.4.ebuild,v 1.3 2004/11/14 10:57:24 mrness Exp $

inherit eutils

DESCRIPTION="An ISDN telecommunication suite"
HOMEPAGE="http://www.capisuite.de"
SRC_URI="http://www.capisuite.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="dev-lang/python
	media-sound/sox
	media-libs/tiff
	virtual/ghostscript
	net-dialup/capi4k-utils"
DEPEND="${RDEPEND}
	sys-devel/patch"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

}

src_compile() {

	myconf="--localstatedir=/var \
		--with-docdir=/usr/share/doc/${P}"

	econf ${myconf} || die "econf failed."
	emake DESTDIR=${D} || die "parallel make failed."

}

src_install() {

	make DESTDIR=${D} install || die "install failed."

	exeinto /etc/init.d
	doexe ${FILESDIR}/capisuite

	dodoc AUTHORS COPYING INSTALL NEWS README TODO

}
