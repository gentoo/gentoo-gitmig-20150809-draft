# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wings/wings-0.98.11.ebuild,v 1.1 2003/06/21 11:07:48 vapier Exp $

DESCRIPTION="excellent 3D polygon mesh modeler"
HOMEPAGE="http://www.wings3d.org/"
SRC_URI="mirror://sourceforge/wings/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"

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
