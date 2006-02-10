# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/chinput/chinput-3.0.2.ebuild,v 1.5 2006/02/10 21:52:38 liquidx Exp $

inherit eutils

MY_P=${P/chinput/Chinput}
DESCRIPTION="Featureful Chinese Input Method XIM Server"
HOMEPAGE="http://www.opencjk.org/~yumj/project-chinput-e.html"
SRC_URI="http://www.opencjk.org/~yumj/download/${MY_P}.tar.gz
	mirror://debian/pool/main/c/chinput/chinput_${PV}-17.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-i18n/unicon
	>=dev-libs/pth-1.2
	>=media-libs/imlib-1.9"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${PN}_${PV}-17.diff.gz
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir /etc
	make prefix=${D}/usr etc_prefix=${D}/etc install
	cd ${S}; dodoc doc/*
}
