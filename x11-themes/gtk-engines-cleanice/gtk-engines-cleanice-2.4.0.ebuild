# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-2.4.0.ebuild,v 1.2 2005/08/15 08:37:00 leonardop Exp $

DESCRIPTION="GTK+2 Cleanice Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/elysium-project/"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc x86"
LICENSE="GPL-2"
IUSE="static"
SLOT="2"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	# Install sample theme
	insinto /usr/share/themes/CleanIce/gtk-2.0
	newins ${FILESDIR}/cleanice-2-gtkrc gtkrc

	dodoc AUTHORS ChangeLog README
}
