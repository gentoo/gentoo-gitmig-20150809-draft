# Copyright 1999-2005 Gentoo Foundation and Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/coriander/coriander-1.0.0_pre3.ebuild,v 1.2 2005/01/25 19:52:38 corsair Exp $

DESCRIPTION="coriander makes the apple isight video4linux compatible"
HOMEPAGE="http://sourceforge.net/projects/coriander/"

SRC_URI="mirror://sourceforge/${PN}/coriander-1.0.0-pre3.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

S=${WORKDIR}/coriander-1.0.0-pre3/

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
