# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gsf-sharp/gsf-sharp-0.7.ebuild,v 1.3 2006/03/25 03:31:08 josejx Exp $

inherit eutils mono autotools

DESCRIPTION="C# bindings for libgsf"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://primates.ximian.com/~joe/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-lang/mono
	>=gnome-extra/libgsf-1.13
	>=dev-dotnet/gtk-sharp-2.3.90"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Bug 118950 - no need to check for libgsf-gnome-1
	# Committed upstream for next release
	epatch ${FILESDIR}/${P}-no-libgsf-gnome-dep.patch

	eautoconf
}

src_install() {
	make install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
}

