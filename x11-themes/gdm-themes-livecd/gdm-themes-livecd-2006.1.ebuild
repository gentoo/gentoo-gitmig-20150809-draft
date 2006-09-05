# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gdm-themes-livecd/gdm-themes-livecd-2006.1.ebuild,v 1.2 2006/09/05 14:52:38 gustavoz Exp $

DESCRIPTION="Gentoo LiveCD theme for the GDM Greeter"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

RDEPEND="gnome-base/gdm"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/gdm/themes
	doins -r *
}
