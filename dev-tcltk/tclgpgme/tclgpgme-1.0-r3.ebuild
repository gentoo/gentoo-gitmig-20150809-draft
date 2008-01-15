# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclgpgme/tclgpgme-1.0-r3.ebuild,v 1.7 2008/01/15 19:00:32 alonbl Exp $

inherit eutils autotools

DESCRIPTION="Tcl/Tk libraries to gpgme."
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	~app-crypt/gpgme-0.3.14"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-build.patch"
	AT_M4DIR="config" eautoreconf
}

src_compile() {
	export GPGME_CONFIG=/usr/bin/gpgme3-config
	econf --with-tcl=/usr/$(get_libdir) --with-tk=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS INSTALL README
}
