# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-1.2.1.ebuild,v 1.4 2001/08/31 03:23:38 pm Exp $



S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.gz"

DEPEND="virtual/glibc
        >=x11-libs/gtk+-1.2
        >=media-libs/imlib-1.9"

src_compile() {

    emake || die

}

src_install () {

    cd src
	 exeinto /usr/X11R6/bin
    doexe gkrellm

    insinto /usr/include/gkrellm
    for i in gkrellm.h gkrellm_private_proto.h gkrellm_public_proto.h
    do
      doins $i
    done

    dodir /usr/X11R6/share/gkrellm/{themes,plugins}

    cd ${S}

    dodoc COPYRIGHT README Changelog
    docinto html
    dodoc Changelog-plugins.html Changelog-themes.html Themes.html
}


