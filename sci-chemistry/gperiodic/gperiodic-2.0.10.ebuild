# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gperiodic/gperiodic-2.0.10.ebuild,v 1.6 2011/03/02 13:17:20 jlec Exp $

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="Periodic table application for Linux"
SRC_URI="http://www.frantz.fi/software/${P}.tar.gz"
HOMEPAGE="http://www.frantz.fi/software/gperiodic.php"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

RDEPEND=">=sys-libs/ncurses-5.2
	x11-libs/gtk+:2
	x11-libs/cairo[X]
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	# The author has removed "unnecessary automake/autoconf setup"

	sed -i -e "s|-DGTK_DISABLE_DEPRECATED|${CFLAGS}|" Makefile
	sed -i -e "/make clean/d" Makefile
	sed -i -e "s|CC=gcc|CC=$(tc-getCC)|" Makefile
	if ! use nls; then
		sed -i -e "/make -C po/d" Makefile
	fi
	emake || die "emake failed!"
}

src_install() {
	sed -i -e "s|/usr/bin|${D}/usr/bin|" Makefile
	sed -i -e "s|/usr/share|${D}/usr/share|" Makefile
	sed -i -e "s|/usr/share|${D}/usr/share|" po/Makefile

	# Create directories - Makefile is quite broken.
	dodir /usr/bin
	dodir /usr/share/pixmaps
	dodir /usr/share/applications

	emake install || die "make install failed."

	# Fix permissions
	chmod 644 "${D}/usr/share/pixmaps/*"
	chmod 644 "${D}/usr/share/applications/*"

	# Fix the chemistry category in the .desktop file, bug 97202.
	sed -i -e "s|Chemestry|Chemistry|" "${D}/usr/share/applications/gperiodic.desktop"

	# The man page seems to have been removed too.
#	doman man/gperiodic.1
	dodoc AUTHORS ChangeLog README NEWS || die
	newdoc po/README README.translation || die
}
