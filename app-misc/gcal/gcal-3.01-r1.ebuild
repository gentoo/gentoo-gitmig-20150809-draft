# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gcal/gcal-3.01-r1.ebuild,v 1.5 2004/02/06 04:19:47 agriffis Exp $

DESCRIPTION="The GNU Calendar - a replacement for cal"
HOMEPAGE="http://www.gnu.org/software/gcal/gcal.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gcal/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~amd64"
IUSE="ncurses nls"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` `use_enable ncurses` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS ATTENTION BUGS COPYING DISCLAIM HISTORY \
		INSTALL LIMITATIONS MANIFEST NEWS README SYMBOLS THANKS TODO

	# Need to fix up paths for scripts in misc directory
	# that are automatically created by the makefile
	for miscfile in ${D}/usr/share/gcal/misc/*/*
	do
		dosed "s:${D%/}::g" ${miscfile/${D}}
	done

	# Rebuild the symlinks that makefile created into the image /usr/bin
	# directory during make install
	dosym /usr/share/gcal/misc/daily/daily /usr/bin/gcal-daily
	dosym /usr/share/gcal/misc/ddiff/ddiff /usr/bin/gcal-ddiff
	dosym /usr/share/gcal/misc/ddiff/ddiffdrv /usr/bin/gcal-ddiffdrv
	dosym /usr/share/gcal/misc/dst/dst /usr/bin/gcal-dst
	dosym /usr/share/gcal/misc/gcalltx/gcalltx /usr/bin/gcal-gcalltx
	dosym /usr/share/gcal/misc/gcalltx/gcalltx.pl /usr/bin/gcal-gcalltx.pl
	dosym /usr/share/gcal/misc/moon/moon /usr/bin/gcal-moon
	dosym /usr/share/gcal/misc/mrms/mrms /usr/bin/gcal-mrms
	dosym /usr/share/gcal/misc/srss/srss /usr/bin/gcal-srss
	dosym /usr/share/gcal/misc/wloc/wlocdrv /usr/bin/gcal-wlocdrv
}
