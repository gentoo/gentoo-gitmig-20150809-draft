# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.5.ebuild,v 1.1 2003/12/08 01:03:59 liquidx Exp $

inherit gnome2

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
LICENSE="LGPL-2.1 GPL-2 DSL"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

src_unpack() {
	unpack ${A}
	sed -e 's:gorilla-default:capplet-icons:' \
		-i ${S}/Gorilla/gtk-2.0/iconrc.in \
		-i ${S}/Gorilla/gtk-2.0/iconrc
	EPATCH_OPTS="-d ${S}/Industrial" epatch ${FILESDIR}/${P}-industrial_uncorrupt.patch
}
