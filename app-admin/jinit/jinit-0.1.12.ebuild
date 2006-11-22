# Copyright 1999-200666666 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/jinit/jinit-0.1.12.ebuild,v 1.3 2006/11/22 19:23:14 masterdriverz Exp $

DESCRIPTION="An alternative to sysvinit which supports the need(8) concept"
HOMEPAGE="http://john.fremlin.de/programs/linux/jinit/"
SRC_URI="http://john.fremlin.de/programs/linux/jinit/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR=${D} install || die
	mv ${D}/usr/sbin ${D}/
	mv ${D}/sbin/init ${D}/sbin/jinit
	dodoc AUTHORS ChangeLog NEWS README TODO
	cp -R example-setup ${D}/usr/share/doc/${PF}/

	#find ${D}/usr/share/doc/${PF}/example-setup -name "Makefile*"
}
