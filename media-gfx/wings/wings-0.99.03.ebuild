# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wings/wings-0.99.03.ebuild,v 1.1 2008/09/19 21:44:34 maekke Exp $

inherit multilib eutils

DESCRIPTION="excellent 3D polygon mesh modeler"
HOMEPAGE="http://www.wings3d.com/"
SRC_URI="mirror://sourceforge/wings/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/erlang-12.2.0
	>=media-libs/esdl-0.96.0626"

pkg_setup() {
	if ! built_with_use media-libs/libsdl opengl ; then
		die "re-emerge libsdl with USE=opengl"
	fi

	ERL_PATH="/usr/$(get_libdir)/erlang/lib/"
	ESDL_PATH="${ERL_PATH}/$(best_version media-libs/esdl | cut -d/ -f2)"
}

src_compile() {
	make ESDL_PATH="${ERL_PATH}/$(best_version media-libs/esdl | cut -d/ -f2)" || die
}

src_install() {
	WINGS_PATH=${ERL_PATH}/${P}
	dodir ${WINGS_PATH}

	find -name 'Makefile*' -exec rm -f '{}' \;
	for subdir in e3d ebin icons plugins plugins_src src fonts ; do
		cp -r ${subdir} "${D}"/${WINGS_PATH}/ || die
	done

	dosym ${WINGS_PATH} ${ERL_PATH}/${PN}
	dosym ${ESDL_PATH} ${ERL_PATH}/esdl
	newbin "${FILESDIR}"/wings.sh wings
	dodoc AUTHORS README
}
