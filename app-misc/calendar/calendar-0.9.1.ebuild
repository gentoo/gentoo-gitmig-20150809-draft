# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/calendar/calendar-0.9.1.ebuild,v 1.13 2004/06/28 03:27:52 vapier Exp $

DESCRIPTION="Standard unix calendar program for Linux, ported from OpenBSD"
HOMEPAGE="http://bsdcalendar.sourceforge.net/"
SRC_URI="http://bsdcalendar.sourceforge.net/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha ~hppa amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodoc README
	cp -R "${S}/calendars" "${D}/usr/share/calendar" || die "cp failed"
	dobin calendar || die "dobin failed"
	doman calendar.1
}
