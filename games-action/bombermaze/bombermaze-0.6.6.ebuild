# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bombermaze/bombermaze-0.6.6.ebuild,v 1.3 2004/02/08 05:42:35 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Bomberman clone for GNOME"
HOMEPAGE="http://www.freesoftware.fsf.org/bombermaze/"
SRC_URI="http://freesoftware.fsf.org/download/bombermaze/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

RDEPEND=">=media-libs/gdk-pixbuf-0.8
	>=gnome-base/gnome-libs-1.0"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	# It normally fails to locate gdk-pixbuf.h
	append-flags `gdk-pixbuf-config --cflags`

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-included-gettext \
		`use_enable nls` || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS TODO || die "dodoc failed"
}
