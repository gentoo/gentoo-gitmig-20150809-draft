# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.96.4.ebuild,v 1.4 2007/08/15 21:20:17 dertobi123 Exp $

inherit eutils

#TODO: headless mode (but not very well tested yet, may still be too
#hardcore)
IUSE="nls dbus gnutls"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ppc sparc x86 ~x86-fbsd"

DEPEND=">=dev-libs/libxml2-2.6.0
	>=x11-libs/gtk+-2.2.1
	dbus? ( sys-apps/dbus )
	gnutls? ( >=net-libs/gnutls-1.0.16 )
	nls? ( >=sys-devel/gettext-0.11.5 )"

src_compile() {
	# gtk-gnutella now uses a custom build script which in turn drives
	# the Configure script. The options for the build script are less
	# arcane, so use that for clarity.

	local myconf

	if ! use nls; then
		myconf="${myconf} --disable-nls"
	fi

	if ! use dbus; then
		myconf="${myconf} --disable-dbus"
	fi

	if ! use gnutls; then
		myconf="${myconf} --disable-gnutls"
	fi

	./build.sh --prefix="/usr" --gtk2 ${myconf}

	emake || die "Compile failed"
}

src_install() {
	dodir /usr/bin
	make INSTALL_PREFIX=${D} install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}
