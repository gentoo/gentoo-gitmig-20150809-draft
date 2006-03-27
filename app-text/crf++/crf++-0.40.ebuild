# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crf++/crf++-0.40.ebuild,v 1.1 2006/03/27 16:03:20 usata Exp $

inherit eutils

MY_P="${P/crf/CRF}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Yet Another CRF toolkit for segmenting/labelling sequential data"
HOMEPAGE="http://chasen.org/~taku/software/CRF++/"
SRC_URI="http://chasen.org/~taku/software/CRF++/src/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="examples"

DEPEND=""

src_test() {
	for task in example/* ; do
		cd ${task}
		./exec.sh || die "failed test in ${task}"
		cd -
	done
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README
	dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}
