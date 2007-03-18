# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libnut/libnut-282.ebuild,v 1.1 2007/03/18 19:18:07 beandog Exp $

inherit flag-o-matic

DESCRIPTION="Library and tools to create NUT multimedia files"
HOMEPAGE="http://svn.mplayerhq.hu/nut/trunk/
	http://wiki.multimedia.cx/index.php?title=NUT"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
	sed -i 's/^CFLAGS\ =\ /CFLAGS\ =\ \-fPIC\ /' config.mak
	emake PREFIX="${D}/usr" || die "emake died"
}

src_install() {
	make PREFIX="${D}/usr" install || die "make install died"
	dodoc README docs/*
	cd ${S}/nututils
	dobin nutindex nutmerge avireader
}
