# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/calendar/calendar-0.9.1.ebuild,v 1.9 2004/04/28 22:29:24 avenj Exp $

DESCRIPTION="Standard unix calendar program for Linux, ported from OpenBSD."
HOMEPAGE="http://bsdcalendar.sourceforge.net/"
SRC_URI="http://bsdcalendar.sourceforge.net/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~mips ~hppa amd64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake || die "emake failed"
}
src_install() {
	dodoc README
	cp -R "${S}/calendars" "${D}/usr/share/calendar" || die "cp failed"
	dobin calendar || die "dobin failed"
	doman calendar.1
}
