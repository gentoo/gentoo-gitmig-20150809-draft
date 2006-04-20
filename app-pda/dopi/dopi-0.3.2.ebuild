# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/dopi/dopi-0.3.2.ebuild,v 1.1 2006/04/20 07:51:58 latexer Exp $

inherit mono fdo-mime

DESCRIPTION="iPod audio manager in C#/Gtk#"
HOMEPAGE="http://www.snorp.net/"
SRC_URI="http://www.snorp.net/files/dopi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/mono
	>=dev-dotnet/ipod-sharp-0.5.5
	>=dev-dotnet/gtk-sharp-2.4.0
	>=dev-libs/glib-2.0"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
