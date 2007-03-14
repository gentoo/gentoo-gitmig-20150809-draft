# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpu/wmcpu-1.4.ebuild,v 1.1 2007/03/14 16:30:46 s4t4n Exp $

inherit flag-o-matic

DESCRIPTION="wmcpu is a dockapp to monitor memory and CPU usage, similar to xosview"
HOMEPAGE="http://dockapps.org/file.php/id/306"
SRC_URI="http://denilsonsa.sh.nu/~denilson/${P}.tar.gz
	http://denilsonsa.selfip.org/~denilson/${P}.tar.gz
	http://dockapps.org/download.php/id/673/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXpm )
		virtual/x11 )"
RDEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile() {
	# We then add the default -Wall from Makefile to CFLAGS
	emake CFLAGS="${CFLAGS} -Wall" || die "emake failed"
}

src_install () {
	dobin wmcpu
	dodoc ChangeLog README
}
