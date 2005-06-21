# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-es/manpages-es-1.55.ebuild,v 1.1 2005/06/21 14:08:07 ferdy Exp $

S1=${WORKDIR}/man-pages-es-${PV}
S2=${WORKDIR}/man-pages-es-extra-0.8a

DESCRIPTION="A somewhat comprehensive collection of Linux spanish man page translations"
SRC_URI="http://ditec.um.es/~piernas/manpages-es/man-pages-es-${PV}.tar.bz2
	http://ditec.um.es/~piernas/manpages-es/man-pages-es-extra-0.8a.tar.gz"
HOMEPAGE="http://ditec.um.es/~piernas/manpages-es/index.html"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~x86"

DEPEND=""
RDEPEND="sys-apps/man"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	# Default src_compile breaks
	:;
}

src_install() {
	# Wipe useless files
	rm -f {${S1},${S2}}/man?/{LEAME,README}

	dodir /usr/share/man/es/
	cp -R {${S1},${S2}}/man?/ ${D}/usr/share/man/es/
}
