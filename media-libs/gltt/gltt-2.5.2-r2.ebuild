# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gltt/gltt-2.5.2-r2.ebuild,v 1.3 2006/06/01 14:10:10 seemant Exp $

inherit eutils libtool gnuconfig

PATCHVER=0.1

DESCRIPTION="GL truetype library"
HOMEPAGE="http://gltt.sourceforge.net/"
SRC_URI="http://gltt.sourceforge.net/download/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glut
	=media-libs/freetype-1*"

PATCHDIR=${WORKDIR}/gentoo

src_unpack() {
	unpack ${A}; cd ${S}
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
}

src_compile() {

	gnuconfig_update
	libtoolize --copy --force
	elibtoolize

	econf \
		--with-x \
		--with-ttf-dir=/usr || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
