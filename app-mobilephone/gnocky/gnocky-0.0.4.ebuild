# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnocky/gnocky-0.0.4.ebuild,v 1.2 2007/08/16 20:55:00 mrness Exp $

DESCRIPTION="GTK-2 version of gnokii"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.8
	>=gnome-base/libglade-2.5.1
	>=app-mobilephone/gnokii-0.6.18"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_install()
{
	einstall || die "make install failed"
}
