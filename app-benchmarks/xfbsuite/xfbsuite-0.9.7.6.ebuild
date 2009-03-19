# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/xfbsuite/xfbsuite-0.9.7.6.ebuild,v 1.9 2009/03/19 16:50:06 josejx Exp $

DESCRIPTION="benchmark suite"
HOMEPAGE="https://sourceforge.net/projects/fbsuite/"
SRC_URI="mirror://sourceforge/fbsuite/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/perl-tk"
RDEPEND="$DEPEND
	x11-misc/xdialog"
PDEPEND="app-benchmarks/nbench
	app-benchmarks/piozone
	app-benchmarks/bonnie++"

src_install() {
	insinto /usr/share/xfbsuite/images
	doins images/*

	dodoc doc/Todo doc/Readme.DE

	dobin bin/{xfbsuite.tk,xfbsuite.pl,xfbsuite.sh} || die

	exeinto /usr/bin/xfbsuite
	doexe bin/{stream,cachebench,NNET.DAT} || die
}
