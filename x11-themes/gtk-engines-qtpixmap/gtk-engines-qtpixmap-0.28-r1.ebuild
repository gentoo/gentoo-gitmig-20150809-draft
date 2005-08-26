# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtpixmap/gtk-engines-qtpixmap-0.28-r1.ebuild,v 1.2 2005/08/26 13:54:59 agriffis Exp $

inherit eutils

MY_P="QtPixmap-${PV}"

DESCRIPTION="A modified version of the original GTK pixmap engine which follows the KDE color scheme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7043"
SRC_URI="http://www.cpdrummond.freeuk.com/${MY_P}.tar.gz"
KEYWORDS="alpha ~amd64 ~ia64 ~mips ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="gtk2"

RDEPEND="!gtk2? (
		>=media-libs/imlib-1.8
		=x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2 )"

DEPEND="${RDEPEND}
	gtk2? (	dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add switches to enable/disable gtk1 and gtk2 engines in the configure
	# script.
	epatch ${FILESDIR}/${P}-gtk_switches.patch

	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf="$(use_enable gtk2)"

	use gtk2 && myconf="${myconf} --disable-gtk1"
	use gtk2 || myconf="${myconf} --enable-gtk1"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
