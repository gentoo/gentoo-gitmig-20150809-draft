# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gkrellmwireless/gkrellmwireless-0.2.2.ebuild,v 1.3 2003/02/13 15:28:13 vapier Exp $
# 26 Apr 2001 21:30 CST blutgens Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A plugin for GKrellM that monitors your wireless network card"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	export PATH="${PATH}:/usr/X11R6/bin"
	make || die

}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins wireless.so
	dodoc README Changelog
}
