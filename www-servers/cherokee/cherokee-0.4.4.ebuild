# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.4.ebuild,v 1.2 2004/09/05 09:34:32 swegener Exp $

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="ftp://alobbs.com/cherokee/${PV}/${P}.tar.gz
	ftp://laurel.datsi.fi.upm.es/pub/linux/cherokee/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/cherokee"
LICENSE="GPL-2"
DEPEND="sys-libs/glibc"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL README
}
