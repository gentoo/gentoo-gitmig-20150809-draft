# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalendar/wmcalendar-0.5.0-r1.ebuild,v 1.6 2008/05/03 07:17:17 drac Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmCalendar is a calendar dockapp for Windowmaker."

HOMEPAGE="http://wmcalendar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"

RDEPEND=">=dev-libs/libical-0.24_rc4
	>=x11-libs/gtk+-2.2.1-r1
	>=x11-libs/libXpm-3.5.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
