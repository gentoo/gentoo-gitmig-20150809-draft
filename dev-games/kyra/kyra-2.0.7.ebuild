# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/kyra/kyra-2.0.7.ebuild,v 1.1 2003/10/25 12:08:38 vapier Exp $

DESCRIPTION="Kyra Sprite Engine"
HOMEPAGE="http://www.grinninglizard.com/kyra/"
SRC_URI="mirror://sourceforge/kyra/kyra_src_${PV//./_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2"

S=${WORKDIR}/${PN}

src_install() {
	einstall || dir
	#emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml docs/*
	[ `use doc` ] && dohtml -r docs/api
}
