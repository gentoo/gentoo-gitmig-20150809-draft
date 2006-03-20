# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalendar/wmcalendar-0.5.0-r1.ebuild,v 1.3 2006/03/20 12:25:52 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmCalendar is a calendar dockapp for Windowmaker."

HOMEPAGE="http://wmcalendar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=">=dev-libs/libical-0.24_rc4
	>=dev-util/pkgconfig-0.15.0
	>=x11-libs/gtk+-2.2.1-r1
	>=sys-apps/sed-4.0.9"

S=${WORKDIR}/${P}/Src

src_unpack()
{
	unpack ${A}
	cd ${WORKDIR}

	# default Makefile overwrites CC and CFLAGS variables so we patch it
	epatch ${FILESDIR}/${P}.makefile.patch

	# Fix compilation issues with gcc >= 4
	epatch ${FILESDIR}/${P}-gcc4.patch

	# remove unneeded SYSTEM variable from Makefile, fixing bug #105730
	cd ${S}
	sed -i -e "s:\$(SYSTEM)::" Makefile

}

src_install()
{
	dodir /usr/bin /usr/man/man1
	make DESTDIR=${D}/usr install || die
	cd .. && dodoc BUGS CHANGES HINTS README TODO || die
}
