# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/chinput/chinput-3.0.2.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

MY_P=${P/chinput/Chinput}
DESCRIPTION="Featureful Chinese Input Method XIM Server"
HOMEPAGE="http://www.opencjk.org/~yumj/project-chinput-e.html"
SRC_URI="http://www.opencjk.org/~yumj/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-i18n/unicon
	>=dev-libs/pth-1.2
	>=media-libs/imlib-1.9"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	einfo "Applying chinput-3.0.2-config.patch"
	patch -p1 < ${FILESDIR}/chinput-3.0.2-config.patch
	# from debian unstable chinput_3.0.2-9
	einfo "Applying chinput-3.0.2-debian.patch"
	patch -p1 < ${FILESDIR}/chinput-3.0.2-debian.patch
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir /etc
	make prefix=${D}/usr etc_prefix=${D}/etc install
	cd ${S}; dodoc doc/*
}
