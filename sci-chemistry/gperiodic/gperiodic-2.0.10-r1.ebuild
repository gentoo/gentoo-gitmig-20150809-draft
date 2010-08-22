# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gperiodic/gperiodic-2.0.10-r1.ebuild,v 1.1 2010/08/22 20:01:11 hwoarang Exp $

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="Periodic table application for Linux"
SRC_URI="http://www.frantz.fi/software/${P}.tar.gz"
HOMEPAGE="http://www.frantz.fi/software/gperiodic.php"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

RDEPEND=">=sys-libs/ncurses-5.2
	=x11-libs/gtk+-2*
	x11-libs/cairo[X]
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_prepare() {
	sed -i -e "s|-DGTK_DISABLE_DEPRECATED|${CFLAGS}|" \
		-e "/make clean/d" -e "/^CC/s:^.*$:CC=$(tc-getCC):" \
		-e "s:\$(CFLAGS):& \${LDFLAGS}:" \
		Makefile || die

	if ! use nls; then
		sed -i -e "/make -C po/d" Makefile || die
	fi
	sed -i -e "s|/usr/bin|${D}/usr/bin|" \
		-e "s|/usr/share|${D}/usr/share|" Makefile || die
	sed -i -e "s|/usr/share|${D}/usr/share|" po/Makefile || die
}

src_install() {
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
