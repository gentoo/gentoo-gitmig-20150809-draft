# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.99.98.ebuild,v 1.7 2003/05/30 02:09:59 lu_zero Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="your favourite PostScript previewer"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="x86 ppc alpha ~sparc"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libglade-2.0.1
	app-text/ghostscript
	>=dev-libs/popt-1.6"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOC="AUTHORS ChangeLog COPYING* MAINTAINERS TODO NEWS README"
