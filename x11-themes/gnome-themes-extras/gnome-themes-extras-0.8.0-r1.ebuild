# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.8.0-r1.ebuild,v 1.1 2004/12/08 03:00:34 obz Exp $

inherit gnome2 eutils

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

SLOT="0"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ~ppc"
IUSE=""
LICENSE="LGPL-2.1 GPL-2 DSL"

RDEPEND=">=x11-libs/gtk+-2
	gnome-base/librsvg"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

src_unpack() {

	unpack ${A}

	EPATCH_OPTS="-d ${S}/Industrial" \
		epatch ${FILESDIR}/${PN}-0.5-industrial_uncorrupt.patch
	# the Smooth engine is provided by gnome-themes, and so
	# conflicts if we install it here.
	sed -i -e "s/Wasp\ Smooth/Wasp/" ${S}/Makefile.in

}
