# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-imonc/gkrellm-imonc-0.2.ebuild,v 1.1 2004/01/20 23:35:01 mholzer Exp $

DESCRIPTION="A GKrellM2 plugin to control a fli4l router"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gkrellm-imonc.sourceforge.net/"

DEPEND="=app-admin/gkrellm-2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}-src-${PV}

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellm-imonc.so
	dodoc README AUTHORS COPYING CHANGELOG
}
