# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capisuite/capisuite-0.4.3.ebuild,v 1.2 2004/02/12 20:53:21 lanius Exp $

DESCRIPTION="patch management script"
HOMEPAGE="http://www.capisuite.de/capisuite/"
SRC_URI="http://www.capisuite.de/capisuite/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-dialup/capi4k-utils
	dev-lang/python"

RDEPEND="sys-devel/patch
	media-sound/sox
	media-libs/tiff
	virtual/ghostscript"

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
