# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtktalog/gtktalog-1.0.1.ebuild,v 1.1 2003/05/05 22:41:38 foser Exp $

DESCRIPTION="The GTK disk catalog."
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/gtktalog"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=sys-libs/zlib-1.1.4"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	econf \
		--enable-htmltitle \
		--enable-mp3info \
		--enable-aviinfo \
		--enable-mpeginfo \
		--enable-modinfo \
		--enable-ogginfo \
		--enable-catalog2 \
		--enable-catalog3 \
		${myconf}

	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
