# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnome-ppp/gnome-ppp-0.3.23.ebuild,v 1.4 2006/03/12 12:38:22 mrness Exp $

inherit gnome2 eutils

MAJOR_V=${PV%.[0-9]*}

DESCRIPTION="A GNOME 2 WvDial frontend"
HOMEPAGE="http://www.icmreza.co.yu/blogs/vladecks/en/?page_id=4"
SRC_URI="http://www.icmreza.co.yu/blogs/vladecks/wp-content/projects/gnome-ppp/download/${MAJOR_V}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND=">=net-dialup/wvdial-1.54
	>=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.4"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool
	${RDEPEND}"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	gnome2_src_install top_builddir="${S}"
}
