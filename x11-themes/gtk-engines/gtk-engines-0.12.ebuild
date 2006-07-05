# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-0.12.ebuild,v 1.3 2006/07/05 05:56:15 vapier Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org

DESCRIPTION="GTK+1 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.8"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog README
}
