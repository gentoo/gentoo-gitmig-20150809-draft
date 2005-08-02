# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-1.2.7.ebuild,v 1.11 2005/08/02 08:48:00 leonardop Exp $

DESCRIPTION="GTK+2 Cleanice Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/elysium-project/"
SRC_URI="mirror://sourceforge/elysium-project/cleanice-theme-${PV}.tar.gz"

KEYWORDS="x86 ppc sparc alpha ia64 hppa amd64"
LICENSE="GPL-2"
IUSE=""
SLOT="2"
S=${WORKDIR}/cleanice-theme-${PV}

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
