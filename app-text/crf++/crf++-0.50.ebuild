# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crf++/crf++-0.50.ebuild,v 1.1 2008/06/15 20:59:21 loki_val Exp $

inherit eutils base

MY_P="${P/crf/CRF}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Yet Another CRF toolkit for segmenting/labelling sequential data"
HOMEPAGE="http://crfpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/crfpp/${MY_P}.tar.gz"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="examples"

DEPEND=""

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_test() {
	for task in example/* ; do
		cd ${task}
		./exec.sh || die "failed test in ${task}"
		cd -
	done
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS README
	dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}
