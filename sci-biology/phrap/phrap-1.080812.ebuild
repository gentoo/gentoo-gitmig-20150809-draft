# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phrap/phrap-1.080812.ebuild,v 1.2 2008/12/31 01:05:13 weaver Exp $

DESCRIPTION="Phrap, swat, cross_match: Shotgun assembly and alignment utilities"
HOMEPAGE="http://www.phrap.org/"
SRC_URI="phrap-${PV}-distrib.tar.gz"

LICENSE="phrap"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please visit http://www.phrap.org/phredphrapconsed.html and obtain the file"
	einfo "\"distrib.tar.gz\", then rename it to \"phrap-${PV}-distrib.tar.gz\""
	einfo "and put it in ${DISTDIR}"
}

src_compile() {
	sed -i 's/CFLAGS=/#CFLAGS=/' makefile
	sed -i 's|#!/usr/local/bin/perl|#!/usr/bin/env perl|' phrapview
	emake || die "emake failed"
}

src_install() {
	dobin cluster cross_match loco phrap phrapview swat
	for i in {general,phrap,swat}.doc ; do
		newdoc ${i} ${i}.txt
	done
}

pkg_postinst() {
	elog If you are operating a non-commercial \(academic or government\)
	elog computer facility which provides access to several independent
	elog investigators, you are required by the licensing agreement to set the
	elog permissions on the executables and source code to allow execute but
	elog not read access, so that the programs may not be copied.
	elog
	elog Phrap documentation is installed in ${ROOT}/usr/share/doc/${P}.
}
