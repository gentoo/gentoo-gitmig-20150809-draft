# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-0.12.ebuild,v 1.1 2005/08/03 06:38:09 leonardop Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org gnuconfig

DESCRIPTION="GTK+1 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.8"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use alpha || use amd64 || use ppc64 ; then
		gnuconfig_update || die 'gnuconfig_update failed'
		libtoolize --force || die 'libtoolize failed'
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
