# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.00.24.ebuild,v 1.5 2007/08/02 13:07:27 uberlord Exp $

inherit eutils

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/penguin/open_source_remind.php"
SRC_URI="http://www.roaringpenguin.com/penguin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE="X"

RDEPEND="X? ( dev-lang/tk )"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${PV}/01-optional-filename.patch"
	epatch "${FILESDIR}/${PV}/03-broken-postscript.patch"
	epatch "${FILESDIR}/${PV}/03-tkremind-no-newlines.patch"
	epatch "${FILESDIR}/${PV}/04-rem-cmd.patch"
}

src_install() {
	# stupid broken makefile...
	einstall || die "first einstall failed"
	dobin www/rem2html

	dodoc README ACKNOWLEDGEMENTS COPYRIGHT WINDOWS doc/README.UNIX \
		doc/WHATSNEW* www/README.*
}
