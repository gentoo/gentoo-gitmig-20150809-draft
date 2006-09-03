# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-0.9.6-r1.ebuild,v 1.18 2006/09/03 20:50:29 kumba Exp $

inherit flag-o-matic

DESCRIPTION="Gnome Text Editor"
HOMEPAGE="http://gedit.sourceforge.net/"
SRC_URI="mirror://gnome//sources/gedit/${PV/.6}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="O"
KEYWORDS="ppc sparc x86"
IUSE="nls"

RDEPEND="<gnome-base/libglade-2
	>=gnome-base/gnome-print-0.30
	=gnome-base/gnome-vfs-1*"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	append-flags `gnome-config --cflags libglade vfs`

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README* THANKS TODO
}
