# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.5.ebuild,v 1.5 2004/03/19 14:18:35 foser Exp $

inherit gnome2

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="x86 ~sparc ~hppa amd64"
IUSE=""
LICENSE="LGPL-2.1 GPL-2 DSL"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0-smooth_engine_gtk_2.4.patch

	sed -e 's:gorilla-default:capplet-icons:' \
		-i ${S}/Gorilla/gtk-2.0/iconrc.in \
		-i ${S}/Gorilla/gtk-2.0/iconrc
	EPATCH_OPTS="-d ${S}/Industrial" epatch ${FILESDIR}/${P}-industrial_uncorrupt.patch
}
