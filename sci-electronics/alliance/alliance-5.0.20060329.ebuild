# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/alliance/alliance-5.0.20060329.ebuild,v 1.1 2006/04/21 20:12:14 calchan Exp $

inherit versionator

MY_PV=$(replace_version_separator 2 '-' )
UPSTREAM_VERSION=$(get_version_component_range 1-2)
DESCRIPTION="Digital IC design tools (simulation, synthesis, place/route, etc...)."
HOMEPAGE="http://www-asim.lip6.fr/recherche/alliance/"
SRC_URI="http://www-asim.lip6.fr/pub/alliance/distribution/${UPSTREAM_VERSION}/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="x11-libs/openmotif"
S=${WORKDIR}/${PN}-${UPSTREAM_VERSION}

src_compile() {
	# Alliance requires everything to be in the same directory
	econf \
		--prefix=/usr/lib/${PN} \
		--mandir=/usr/lib/${PN}/man \
		--with-x \
		--with-motif \
		--with-xpm \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D}
	insinto /etc
	newins distrib/etc/alc_env.sh alliance.env
}

pkg_postinst() {
	einfo "Users should source /etc/alliance.env before working with Alliance tools."
}
