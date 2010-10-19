# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/calendar/calendar-0.9.1.ebuild,v 1.20 2010/10/19 06:00:24 leio Exp $

inherit toolchain-funcs

DESCRIPTION="Standard unix calendar program for Linux, ported from OpenBSD"
HOMEPAGE="http://bsdcalendar.sourceforge.net/"
SRC_URI="http://bsdcalendar.sourceforge.net/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dodoc README
	cp -R "${S}/calendars" "${D}/usr/share/calendar" || die "cp failed"
	dobin calendar || die "dobin failed"
	doman calendar.1
}
