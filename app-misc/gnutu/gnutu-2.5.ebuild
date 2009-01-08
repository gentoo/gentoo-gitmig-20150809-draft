# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnutu/gnutu-2.5.ebuild,v 1.1 2009/01/08 18:38:44 jer Exp $

inherit mono

DESCRIPTION="GNU Student's Timetable for polish users"
HOMEPAGE="http://gnutu.devnull.pl/"
SRC_URI="http://gnutu.devnull.pl/download/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.2.5.1-r1
	>=dev-dotnet/gtk-sharp-2.10.0
	>=dev-dotnet/glade-sharp-2.10.0"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog AUTHORS NEWS README
}
