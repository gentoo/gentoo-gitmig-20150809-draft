# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-smooth/gtk-engines-smooth-0.6.0.1-r2.ebuild,v 1.2 2005/08/26 13:56:16 agriffis Exp $

MY_P="gtk-smooth-engine-${PV}"

DESCRIPTION="GTK+1 Smooth Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/smooth-engine/"
SRC_URI="mirror://sourceforge/smooth-engine/${MY_P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="1"
IUSE="static"

S=${WORKDIR}/${MY_P}

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf"

src_compile() {
	local myconf="--enable-gtk-1 --disable-gtk-2 $(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS NEWS README
}
