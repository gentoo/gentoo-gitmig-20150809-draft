# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-smooth/gtk-engines-smooth-0.6.0.1-r1.ebuild,v 1.1 2005/08/02 12:23:53 leonardop Exp $

MY_P="gtk-smooth-engine-${PV}"

DESCRIPTION="GTK+1 Smooth Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${MY_P}.tar.gz"
KEYWORDS="x86 ~alpha ~ppc ~amd64 sparc"
LICENSE="GPL-2"
SLOT="1"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf"

src_compile() {
	local myconf="--enable-gtk-1 --disable-gtk-2"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS NEWS README
}
