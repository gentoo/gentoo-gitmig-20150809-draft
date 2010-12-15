# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/basenji/basenji-0.7.1.ebuild,v 1.3 2010/12/15 14:57:58 phajdan.jr Exp $

EAPI="3"

DESCRIPTION="Basenji is a volume indexing tool designed for easy and fast indexing of volume collections."
HOMEPAGE="http://launchpad.net/basenji"
SRC_URI="http://launchpad.net/basenji/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86"
IUSE=""

CDEPEND="dev-dotnet/gtk-sharp
	dev-dotnet/glib-sharp
	dev-dotnet/dbus-glib-sharp
	dev-dotnet/gnome-sharp"

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}
	sys-fs/udisks"

src_prepare() {
	sed -i -e "s/-pkg:mono-cairo/-r:Mono.Cairo/" Basenji/Makefile || die "sed failed."
}

src_configure() {
	./configure --prefix="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
