# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnocky/gnocky-0.0.3.ebuild,v 1.1 2005/10/31 10:31:50 s4t4n Exp $

DESCRIPTION="GTK-2 version of gnokii"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.8
	>=gnome-base/libglade-2.5.1
	>=app-mobilephone/gnokii-0.6.7-r1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile()
{
	econf || die "configure failed"

	#Fix incorrect LDADD in Makefile
	sed -i -e "s|gnocky_LDADD = -pthread -L |gnocky_LDADD = |" src/Makefile

	emake || die "make failed"
}

src_install()
{
	einstall || die "make install failed"
}
