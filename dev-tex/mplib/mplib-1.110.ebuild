# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mplib/mplib-1.110.ebuild,v 1.1 2008/11/29 14:04:54 aballier Exp $

EAPI=1

inherit libtool

DESCRIPTION="New, revamped version of the MetaPost interpreter"
HOMEPAGE="http://foundry.supelec.fr/projects/metapost"
SRC_URI="http://foundry.supelec.fr/frs/download.php/696/${PN}-beta-${PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
# We enalbe lua by default because it will be needed by luatex
IUSE="+lua"

RDEPEND="virtual/tex-base
	lua? ( dev-lang/lua )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-beta-${PV}/src/texk/web2c/mpdir

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_compile() {
	econf $(use_enable lua)
	# parallel make fails from time to time... needs to be fixed
	emake KPSESRCDIR=/usr/include/kpathsea KPSELIB=-lkpathsea -j1 || die "failed to build mplib"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	mv "${D}/usr/bin/mpost" "${D}/usr/bin/mpost-${P}" || die "failed to rename mpost"
	dodoc "${WORKDIR}/${PN}-beta-${PV}/CHANGES"	"${WORKDIR}/${PN}-beta-${PV}/README"
}
