# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@rocketmail.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-mailwatch/gkrellm-mailwatch-0.7.2.ebuild,v 1.1 2002/04/26 09:22:21 seemant Exp $

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GKrellM plugin that shows the status of additional mail boxes"
SRC_URI="http://gkrellm.luon.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

DEPEND=">=app-admin/gkrellm-1.0.6
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1"


src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe mailwatch.so
	dodoc README Changelog TODO
}
