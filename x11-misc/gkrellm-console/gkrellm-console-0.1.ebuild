# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-console/gkrellm-console-0.1.ebuild,v 1.1 2002/04/14 14:22:51 seemant Exp $

MY_P=consolewatch-0.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GKrellM plugin that shows the users logged into each console"
SRC_URI="http://gkrellm.luon.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/consolewatch.phtml"

DEPEND=">=app-admin/gkrellm-1.0.6
                >=x11-libs/gtk+-1.2.10-r4
                >=media-libs/imlib-1.9.10-r1"

src_compile() {
        emake || die
}

src_install () {
        insinto /usr/lib/gkrellm/plugins
        doins consolewatch.so
        dodoc README Changelog TODO
}
