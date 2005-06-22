# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-es/manpages-es-1.55.ebuild,v 1.3 2005/06/22 15:05:22 ferdy Exp $

manpages=man-pages-es-${PV}
manpagesextra=man-pages-es-extra-0.8a

S1=${WORKDIR}/${manpages}
S2=${WORKDIR}/${manpagesextra}

DESCRIPTION="A somewhat comprehensive collection of Linux spanish man page translations"
SRC_URI="http://ditec.um.es/~piernas/manpages-es/${manpages}.tar.bz2
	http://ditec.um.es/~piernas/manpages-es/${manpagesextra}.tar.gz"
HOMEPAGE="http://ditec.um.es/~piernas/manpages-es/index.html"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"

DEPEND=""
RDEPEND="sys-apps/man"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	# Default src_compile breaks
	:;
}

src_install() {
	local d f

	# Wipe useless files
	rm -f {${S1},${S2}}/man?/{LEAME,README}

	dodir /usr/share/man/es/man{1,2,3,4,5,6,7,8}

	# This is needed because manpages-es has broken encodings upstream
	for d in {${S1},${S2}} ; do
		cd ${d}
		file -i man?/* | while read f ; do
			iconv -f ${f##*=} \
				-t iso8859-1 ${d}/${f%%:*} \
				-o ${D}/usr/share/man/es/${f%%:*}
		done
	done
}
