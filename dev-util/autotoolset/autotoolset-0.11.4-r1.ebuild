# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autotoolset/autotoolset-0.11.4-r1.ebuild,v 1.5 2008/01/23 12:00:37 opfer Exp $

inherit eutils fixheadtails

DESCRIPTION="colection of small tools to simplify project development with autotools"
HOMEPAGE="http://autotoolset.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}-misc-pending-upstream-fixes.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	app-arch/sharutils
	app-arch/gzip
	dev-lang/perl"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1107954&group_id=75790&atid=545068
	epatch "${DISTDIR}"/${P}-misc-pending-upstream-fixes.gz
	ht_fix_file src/gpl/gpl.sh
}

src_compile() {
	econf EMACS=no || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
