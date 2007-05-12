# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glsof/glsof-0.10.0_alpha4.ebuild,v 1.1 2007/05/12 12:55:48 ticho Exp $

inherit gnome2  # Saves us work

MY_P=${P/_/-pre-}
DESCRIPTION="GTK+ GUI for LSOF"
HOMEPAGE="http://glsof.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	dev-libs/libxml2
	sys-process/lsof"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	sed -i -e "s:^glsof_LDFLAGS = :glsof_LDFLAGS = -export-dynamic :" \
		src/Makefile.in
}

DOCS="AUTHORS COPYING ChangeLog INSTALL README"
