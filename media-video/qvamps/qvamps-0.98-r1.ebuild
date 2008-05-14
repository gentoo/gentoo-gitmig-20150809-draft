# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qvamps/qvamps-0.98-r1.ebuild,v 1.3 2008/05/14 21:53:57 sbriesen Exp $

inherit eutils toolchain-funcs multilib flag-o-matic

DESCRIPTION="Qt frontend for vamps"
HOMEPAGE="http://vamps.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-lang/perl
	dev-perl/PerlQt
	>=media-libs/libdvdread-0.9.6"

DEPEND="${COMMON_DEPEND}
	dev-lang/swig"

RDEPEND="${COMMON_DEPEND}
	>=media-video/dvdauthor-0.6.11
	>=media-video/mjpegtools-1.8.0
	>=media-video/vamps-0.99.2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# set correct libdir
	sed -i -e "s:/lib/qvamps/:/$(get_libdir)/qvamps/:g" Makefile qvamps

	# apply patches (see bug #144691)
	epatch "${FILESDIR}/${P}-fgcmgr.diff"
	epatch "${FILESDIR}/${P}-xmlwriter.diff"
}

src_compile() {
	# Need to fake out Qt or we'll get sandbox problems
	export REALHOME="${HOME}" HOME="${T}/fakehome"
	addwrite "${QTDIR}/etc/settings"
	mkdir -p "${HOME}/".{kde,qt}

	# -fPIC is needed for shared objects on some platforms (amd64 and others)
	append-flags -fPIC

	emake PREFIX="/usr" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make PREFIX="${D}usr" install || die "make install failed"
	dodoc ChangeLog README INSTALL

	newicon images/icon.png qvamps.png
	make_desktop_entry qvamps qVamps qvamps
}
