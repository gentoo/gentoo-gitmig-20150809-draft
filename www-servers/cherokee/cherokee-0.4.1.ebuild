# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.1.ebuild,v 1.2 2004/09/05 09:34:32 swegener Exp $

inherit eutils

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="ftp://laurel.datsi.fi.upm.es/pub/linux/cherokee/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/cherokee"
LICENSE="GPL-2"
DEPEND="sys-libs/glibc"
KEYWORDS="x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc3.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
