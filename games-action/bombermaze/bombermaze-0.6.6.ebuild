# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bombermaze/bombermaze-0.6.6.ebuild,v 1.7 2006/04/18 21:04:42 tupone Exp $

inherit flag-o-matic eutils

DESCRIPTION="Bomberman clone for GNOME"
HOMEPAGE="http://www.freesoftware.fsf.org/bombermaze/"
SRC_URI="http://freesoftware.fsf.org/download/bombermaze/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=media-libs/gdk-pixbuf-0.8
	>=gnome-base/gnome-libs-1.0"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	sed -i \
		-e 's:destdir=:destdir=$(DESTDIR):' \
		po/Makefile.in.in || die "sed po"
}

src_compile() {
	# It normally fails to locate gdk-pixbuf.h
	append-flags $(gdk-pixbuf-config --cflags)

	econf $(use_enable nls) || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS TODO
}
