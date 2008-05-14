# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-aurora/gtk-engines-aurora-1.4.ebuild,v 1.1 2008/05/14 07:26:41 drac Exp $

DESCRIPTION="Aurora GTK+ Theme Engine"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=56438"
SRC_URI="http://gnome-look.org/CONTENT/content-files/56438-Aurora-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/aurora-${PV}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	tar -xzf aurora-${PV}.tar.gz || die "unpacking failed."
	tar -xjf gtkrc_themes.tar.bz2 || die "unpacking failed."
}

src_compile() {
	econf --disable-dependency-tracking --enable-animation
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/themes
	doins -r ../Aurora* || die "doins failed."
}
