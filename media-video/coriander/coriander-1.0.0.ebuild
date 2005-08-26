# Copyright 1999-2005 Gentoo Foundation and Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/coriander/coriander-1.0.0.ebuild,v 1.2 2005/08/26 16:17:54 seemant Exp $

DESCRIPTION="A GUI for firewire cameras"
HOMEPAGE="http://sourceforge.net/projects/coriander/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"
IUSE=""

S=${WORKDIR}/coriander-1.0.0/

DEPEND="media-libs/libdc1394
	gnome-base/gnome-libs
	sys-devel/libtool"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc NEWS README AUTHORS
}
