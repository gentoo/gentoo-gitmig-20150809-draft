# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-mail/gkrellm-mail-0.7.2.ebuild,v 1.2 2002/05/23 06:50:20 seemant Exp $

MY_P=mailwatch-0.7.2
S=${WORKDIR}/${P}
DESCRIPTION="GKrellM-mailwatch is a plugin to watch additional mailboxes."
SRC_URI="http://gkrellm.luon.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

DEPEND=">=app-admin/gkrellm-1.0.6
        =x11-libs/gtk+-1.2*
        >=media-libs/imlib-1.9.10-r1"


src_compile() {
    emake || die
}

src_install () {
    insinto /usr/lib/gkrellm/plugins
    doins mailwatch.so
    dodoc README Changelog
}
