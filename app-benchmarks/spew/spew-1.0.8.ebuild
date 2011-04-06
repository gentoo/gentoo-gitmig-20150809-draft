# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/spew/spew-1.0.8.ebuild,v 1.1 2011/04/06 22:51:08 blueness Exp $

EAPI=3

inherit autotools eutils

DESCRIPTION="Measures I/O performance and/or generates I/O load"
HOMEPAGE="http://spew.berlios.de/"
SRC_URI="ftp://ftp.berlios.de/pub/spew/1.0.8/spew-1.0.8.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="static"

DEPEND="static? ( sys-libs/ncurses[-gpm] dev-libs/popt[static-libs] )
	!static? ( sys-libs/ncurses dev-libs/popt )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/remove-symlinks-makefile.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static static-link) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym ${PN} /usr/bin/gorge
	dosym ${PN} /usr/bin/regorge
	dosym ${PN}.1.bz2 /usr/share/man/man1/gorge.1.bz2
	dosym ${PN}.1.bz2 /usr/share/man/man1/reorge.1.bz2
}
