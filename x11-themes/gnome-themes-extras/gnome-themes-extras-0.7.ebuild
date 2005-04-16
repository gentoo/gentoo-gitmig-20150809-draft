# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.7.ebuild,v 1.6 2005/04/16 23:41:42 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

LICENSE="LGPL-2.1 GPL-2 DSL"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	gnome-base/librsvg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

src_unpack() {

	unpack ${A}

	sed -e 's:gorilla-default:capplet-icons:' \
		-i ${S}/Gorilla/gtk-2.0/iconrc.in \
		-i ${S}/Gorilla/gtk-2.0/iconrc
	EPATCH_OPTS="-d ${S}/Industrial" \
		epatch ${FILESDIR}/${PN}-0.5-industrial_uncorrupt.patch
}
