# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/magicfilter/magicfilter-2.3d.ebuild,v 1.3 2009/08/08 21:00:28 ssuominen Exp $

inherit eutils

MY_P=${PN}-2.3.d

DESCRIPTION="Customizable, extensible automatic printer filter"
HOMEPAGE="http://www.pell.portland.or.us/~orc/Code/magicfilter/"
SRC_URI="http://www.pell.portland.or.us/~orc/Code/magicfilter/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/ghostscript
	>=app-arch/bzip2-1.0.1-r4
	>=app-arch/gzip-1.2.4a-r6
	sys-apps/file"
RDEPEND="${DEPEND}
	virtual/lpr"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_compile() {
	has_version 'net-print/lprng' \
		&& myconf="--with-lprng"

	./configure.sh \
		--prefix="${D}/usr" \
		--filterdir="${D}/usr/share/magicfilter/filters" \
		${myconf}

	# Fix headers in filters
	cd filters
	for f in *.def; do
		mv $f $f.old
		( read l; echo '#!/usr/bin/magicfilter '; cat ) <$f.old >$f
	done
	cd ..

	sed -i -e "s/commoninstall: textonly cfmagic/commoninstall: textonly/" Makefile

	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
