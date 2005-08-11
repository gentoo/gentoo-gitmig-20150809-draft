# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wings/wings-0.98.29b.ebuild,v 1.2 2005/08/11 21:53:33 vapier Exp $

DESCRIPTION="excellent 3D polygon mesh modeler"
HOMEPAGE="http://www.wings3d.com/"
SRC_URI="mirror://sourceforge/wings/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/erlang-9c
	>=media-libs/esdl-0.93.0526"

ERL_PATH=/usr/lib/erlang/lib/

src_compile() {
	make ESDL_PATH="${ERL_PATH}/$(best_version media-libs/esdl | cut -d/ -f1)" || die
}

src_install() {
	WINGS_PATH=${ERL_PATH}/${P}
	dodir ${WINGS_PATH}

	find -name 'Makefile*' -exec rm -f '{}' \;
	for subdir in e3d ebin icons plugins plugins_src src ; do
		cp -r ${subdir} ${D}/${WINGS_PATH}/ || die
	done

	dosym ${WINGS_PATH} ${ERL_PATH}/${PN}
	newbin ${FILESDIR}/wings.sh wings
	dodoc AUTHORS README
}
