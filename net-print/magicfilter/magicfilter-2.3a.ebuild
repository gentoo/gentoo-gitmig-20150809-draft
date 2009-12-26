# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/magicfilter/magicfilter-2.3a.ebuild,v 1.7 2009/12/26 17:44:05 pva Exp $

inherit eutils

IUSE=""

MY_P="${PN}-2.3.a"

DESCRIPTION="Customizable, extensible automatic printer filter"
HOMEPAGE="http://www.pell.portland.or.us/~orc/Code/magicfilter/"
SRC_URI="http://www.pell.portland.or.us/~orc/Code/magicfilter/${MY_P}.tar.gz"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="x86"

DEPEND="app-text/ghostscript-gpl
	>=app-arch/bzip2-1.0.1-r4
	>=app-arch/gzip-1.2.4a-r6
	sys-apps/file"

RDEPEND="${DEPEND}
	virtual/lpr"

S=${WORKDIR}/${MY_P}

src_compile() {
	has_version 'net-print/lprng' \
		&& myconf="--with-lprng"

	./configure.sh \
		--prefix=${D}/usr \
		--filterdir=${D}/usr/share/magicfilter/filters \
		${myconf}

	sed -i -e "s/commoninstall: textonly cfmagic/commoninstall: textonly/" Makefile

	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
