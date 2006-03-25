# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gsf-sharp/gsf-sharp-0.6.ebuild,v 1.3 2006/03/25 03:31:08 josejx Exp $

inherit mono

DESCRIPTION="C# bindings for libgsf"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://primates.ximian.com/~joe/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-lang/mono
	>=gnome-extra/libgsf-1.12.1
	>=dev-dotnet/gtk-sharp-2"

src_install() {
	make install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
}

