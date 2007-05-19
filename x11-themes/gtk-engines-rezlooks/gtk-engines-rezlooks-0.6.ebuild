# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-rezlooks/gtk-engines-rezlooks-0.6.ebuild,v 1.2 2007/05/19 16:45:05 welp Exp $

DESCRIPTION="Rezlooks GTK+ Engine"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=39179"
SRC_URI="http://www.gnome-look.org/content/files/39179-rezlooks-0.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

S="${WORKDIR}/rezlooks-${PV}"

src_compile() {
	econf --enable-animation || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
