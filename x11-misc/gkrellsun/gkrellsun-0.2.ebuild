# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@rocketmail.com>
# $header$

S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin that shows sunrise and sunset times."
SRC_URI="http://nwalsh.com/hacks/gkrellsun/${P}.tar.gz"
HOMEPAGE="http://nwalsh.com/hacks/gkrellsun"

DEPEND=">=app-admin/gkrellm-1.0.6
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe gkrellsun.so
	dodoc README AUTHORS COPYING
}
