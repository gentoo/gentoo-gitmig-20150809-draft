# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-benchmarks/xfbsuite-0.9.7.3, 2004/04/12 13:22:09


DESCRIPTION="benchmark suite"
HOMEPAGE="https://sourceforge.net/projects/fbsuite/"
SRC_URI="mirror://sourceforge/fbsuite/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""


DEPEND="dev-lang/perl
	dev-perl/perl-tk"

src_install() {
	insinto /usr/share/xfbsuite/images
	doins images/*

	dodoc doc/Todo doc/Readme.DE

	dobin bin/{xfbsuite.tk,xfbsuite.pl,xfbsuite.sh}

	exeinto /usr/bin/xfbsuite
	doexe bin/{stream,cachebench,nbench,NNET.DAT,bonnie++,piozone}
}
