# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/slib/slib-3.1.4-r2.ebuild,v 1.2 2007/05/29 11:57:13 hkbst Exp $

inherit versionator eutils

#version magic thanks to masterdriverz and UberLord using bash array instead of tr
trarr="0abcdefghi"
MY_PV="$(get_version_component_range 1)${trarr:$(get_version_component_range 2):1}$(get_version_component_range 3)"

MY_P=${PN}${MY_PV}
S=${WORKDIR}/${PN}
DESCRIPTION="library providing functions for Scheme implementations"
SRC_URI="http://swiss.csail.mit.edu/ftpdir/scm/${MY_P}.zip"

HOMEPAGE="http://swiss.csail.mit.edu/~jaffer/SLIB"

SLOT="0"
LICENSE="public-domain BSD"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="" #test"

#unzip for unpacking
RDEPEND=""
DEPEND="app-arch/unzip"
#		test? ( dev-scheme/scm )"

# maybe also do "make infoz"
src_install() {
	INSTALL_DIR="/usr/share/slib/"

	insinto ${INSTALL_DIR} #don't install directly into guile dir
	doins *.scm
	doins *.init
	dodoc ANNOUNCE ChangeLog FAQ README
	doinfo slib.info
	dosym ${INSTALL_DIR} /usr/share/guile/slib # link from guile dir
	dosym ${INSTALL_DIR} /usr/lib/slib
	dodir /etc/env.d/ && echo "SCHEME_LIBRARY_PATH=\"${INSTALL_DIR}\"" > ${D}/etc/env.d/50slib
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && pkg_config
}

pkg_config() {
	install_slib dev-scheme/guile "guile -c \"(use-modules (ice-9 slib)) (require 'new-catalog)\""
#	install_slib dev-scheme/gauche "gosh -e \"(require 'new-catalog)\""
}

install_slib() {
	if has_version $1; then
		einfo "Registering slib with $1..."
#		echo running: $2
		eval $2
	else
		einfo "$1 not installed, not registering ..."
	fi
}