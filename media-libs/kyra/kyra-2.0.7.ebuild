# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/kyra/kyra-2.0.7.ebuild,v 1.1 2003/10/21 07:14:09 mr_bones_ Exp $

MY_PV=${PV//./_}
S=${WORKDIR}/${PN}
DESCRIPTION="Kyra Sprite Engine"
HOMEPAGE="http://www.grinninglizard.com/kyra/index.html"
SRC_URI="mirror://sourceforge/kyra/kyra_src_${MY_PV}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="doc"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2"

src_install() {
	einstall                    || die
	dodoc ChangeLog NEWS README || die "dodoc failed"
	dohtml docs/*.*             || die "dohtml failed"
	if [ `use doc` ] ; then
		dohtml -r docs/api      || die "dohtml (api) failed"
	fi
}
