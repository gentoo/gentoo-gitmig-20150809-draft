# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-radio/gkrellm-radio-2.0.4.ebuild,v 1.3 2004/09/02 18:22:39 pvdabeel Exp $

IUSE="lirc"

S=${WORKDIR}/${PN}
DESCRIPTION="A minimalistic GKrellM2 plugin to control radio tuners."
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellm-radio.phtml"

DEPEND="=app-admin/gkrellm-2*
	>=media-libs/imlib-1.9.14-r1
	lirc? ( app-misc/lirc )"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc"

src_compile() {
	use lirc && myconf="${myconf} WITH_LIRC=1"
	emake ${myconf} || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe radio.so
	dodoc README CHANGES
}
