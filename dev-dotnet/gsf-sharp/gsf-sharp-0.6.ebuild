# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gsf-sharp/gsf-sharp-0.6.ebuild,v 1.1 2005/11/22 23:26:01 dsd Exp $

inherit mono

DESCRIPTION="C# bindings for libgsf"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://primates.ximian.com/~joe/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/mono
	>=gnome-extra/libgsf-1.12.1
	>=dev-dotnet/gtk-sharp-2"

src_install() {
	make install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
}

