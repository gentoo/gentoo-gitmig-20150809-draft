# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-ChaSen/Text-ChaSen-1.03.ebuild,v 1.7 2006/08/06 00:20:34 mcummings Exp $

inherit perl-module

DESCRIPTION="Chasen library module for Perl."
SRC_URI="http://www.daionet.gr.jp/~knok/chasen/${P}.tar.gz
	http://www.daionet.gr.jp/~knok/chasen/ChaSen.pm-1.03-pod-fix.diff"
HOMEPAGE="http://www.daionet.gr.jp/~knok/chasen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=app-text/chasen-2.2.9
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${DISTDIR}/ChaSen.pm-1.03-pod-fix.diff
}

