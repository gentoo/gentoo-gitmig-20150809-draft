# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-1.3.ebuild,v 1.3 2003/03/29 02:15:27 liquidx Exp $

IUSE=""
DESCRIPTION="stardict - English-Chinese dictionary."
HOMEPAGE=""	# No known homepage - FIXME
SRC_URI="ftp://ftp.cn.FreeBSD.org/pub/ported/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/motif"
RDEPEND="${DEPEND}"

S=${WORKDIR}/zh-${P}

src_unpack () {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/stardict-gentoo.patch || die
}

src_compile() {
	./configure --prefix=/usr
	make all || die
}

src_install () {
	make prefix=${D}/usr install || die
	insinto /usr/share/stardict
	doins ${FILESDIR}/stardict-config.sh
	dodoc doc/faq doc/readme.txt doc/readme_en.txt
}

pkg_postinst () {
	einfo
	einfo '	To set up stardict with the correct'
	einfo '	font for Big5 or GB run'
	einfo '	    "bash /usr/share/stardict/stardict-config.sh"'
	einfo
}
