# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@rocketmail.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellsun/gkrellsun-0.2.ebuild,v 1.4 2002/05/23 06:50:20 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
SRC_URI="http://nwalsh.com/hacks/gkrellsun/${P}.tar.gz"
HOMEPAGE="http://nwalsh.com/hacks/gkrellsun"

DEPEND=">=app-admin/gkrellm-1.2.9
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellsun.so
	dodoc README AUTHORS COPYING
}
