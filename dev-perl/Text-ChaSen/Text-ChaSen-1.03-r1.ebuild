# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-ChaSen/Text-ChaSen-1.03-r1.ebuild,v 1.2 2004/07/22 23:46:58 dholm Exp $

inherit perl-module

DESCRIPTION="Chasen library module for Perl."
SRC_URI="http://www.daionet.gr.jp/~knok/chasen/${P}.tar.gz
	http://www.daionet.gr.jp/~knok/chasen/ChaSen.pm-1.03-pod-fix.diff"
HOMEPAGE="http://www.daionet.gr.jp/~knok/chasen/"

SLOT="0"
LICENSE="chasen"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=app-text/chasen-2.2.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/ChaSen.pm-1.03-pod-fix.diff
	sed -i -e '5a"LD" => "g++",' Makefile.PL || die
}
