# Copyright 1999-2004 Gentoo Foundation and Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/coriander/coriander-1.0.0.ebuild,v 1.1 2004/10/22 13:52:55 pvdabeel Exp $

DESCRIPTION="coriander makes the apple isight video4linux compatible"
HOMEPAGE="http://sourceforge.net/projects/coriander/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE=""

S=${WORKDIR}/coriander-1.0.0/

DEPEND="media-plugins/libdc1394
	gnome-base/gnome-libs
	sys-devel/libtool"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc NEWS README AUTHORS
}
