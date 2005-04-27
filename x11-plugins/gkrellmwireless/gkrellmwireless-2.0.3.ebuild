# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmwireless/gkrellmwireless-2.0.3.ebuild,v 1.7 2005/04/27 18:01:31 herbs Exp $

inherit multilib

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A plugin for GKrellM that monitors your wireless network card"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~amd64"

DEPEND="=app-admin/gkrellm-2*"


src_compile() {
	export PATH="${PATH}:/usr/X11R6/bin"
	make || die

}

src_install () {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins wireless.so
	dodoc README Changelog
}
