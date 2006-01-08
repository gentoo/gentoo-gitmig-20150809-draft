# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/graphlcd-base/graphlcd-base-0.1.3_pre4.ebuild,v 1.1 2006/01/08 15:27:11 hd_brummy Exp $

inherit eutils flag-o-matic

MY_P="${P/_/-}"

S=${WORKDIR}/${MY_P}

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://www.powarman.de"
SRC_URI="http://home.arcor.de/andreas.regel/files/graphlcd/${MY_P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="truetype"

DEPEND="truetype? ( media-libs/freetype
		media-fonts/corefonts )"


src_unpack() {

	unpack ${A}
	cd ${S}

	use !truetype && sed -i "s:HAVE_FREETYPE2:#HAVE_FREETYPE2:" Make.config

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
}

src_compile() {

	# Change CFLAGS for amd64 which needs -fPIC in plugins
	if [[ "${ARCH}" == "amd64" ]]; then
		ebegin "Adding -fPIC to CXXFLAGS for amd64"
		append-flags -fPIC
		eend 0
	fi

	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D}/usr install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
