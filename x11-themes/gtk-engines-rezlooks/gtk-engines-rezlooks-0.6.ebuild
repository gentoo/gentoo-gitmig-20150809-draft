# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-rezlooks/gtk-engines-rezlooks-0.6.ebuild,v 1.5 2008/12/18 18:08:49 ssuominen Exp $

DESCRIPTION="Rezlooks GTK+ Engine"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=39179"
SRC_URI="http://www.gnome-look.org/content/files/39179-rezlooks-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/rezlooks-${PV}

src_compile() {
	econf --disable-dependency-tracking --enable-animation
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CREDITS NEWS README
}
