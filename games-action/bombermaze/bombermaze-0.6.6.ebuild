# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bombermaze/bombermaze-0.6.6.ebuild,v 1.2 2004/02/03 00:10:21 mr_bones_ Exp $

DESCRIPTION="Bomberman clone for GNOME"
SRC_URI="http://freesoftware.fsf.org/download/bombermaze/${P}.tar.gz"
HOMEPAGE="http://www.freesoftware.fsf.org/bombermaze/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

RDEPEND=">=media-libs/gdk-pixbuf-0.8
	>=gnome-base/gnome-libs-1.0"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	# It normally fails to locate gdk-pixbuf.h
	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
	CXXFLAGS="${CXXFLAGS} `gdk-pixbuf-config --cflags`"

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
