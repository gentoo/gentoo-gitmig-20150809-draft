# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.6.ebuild,v 1.4 2004/04/03 07:13:39 pylon Exp $

inherit gnome2

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ppc"
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
	# fix issues with gtk+ 2.4 (#44988)
	epatch ${FILESDIR}/${PN}-0-smooth_engine_gtk_2.4.patch

	sed -e 's:gorilla-default:capplet-icons:' \
		-i ${S}/Gorilla/gtk-2.0/iconrc.in \
		-i ${S}/Gorilla/gtk-2.0/iconrc
	EPATCH_OPTS="-d ${S}/Industrial" \
		epatch ${FILESDIR}/${PN}-0.5-industrial_uncorrupt.patch
}
