# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# /home/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-1.0.8.ebuild,v 1.1 2001/05/06 16:32:43 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${A}"

DEPEND="virtual/glibc
        >=x11-libs/gtk+-1.2
        >=media-libs/imlib-1.9
	nls? ( sys-devel/gettext )"

src_compile() {

    if [ "`use nls`" ] ; then
      ./enable_nls
      try make
    else
      try make
    fi

}

src_install () {

    cd ${S}/src
    dobin gkrellm

    insinto /usr/include/gkrellm
    for i in gkrellm.h gkrellm_private_proto.h gkrellm_public_proto.h
    do
      doins $i
    done

    dodir /usr/share/gkrellm
    dodir /usr/share/gkrellm/plugins
    dodir /usr/share/gkrellm/themes

    if [ "`use nls`" ] ; then
    cd ${S}/locale
    try make enable_nls=1 INSTALL_PREFIX=${D} install
    fi
    
    cd ${S}
    
    doman gkrellm.1
    docinto /usr/doc
    dodoc COPYRIGHT README Changelog
    docinto html
    dodoc Changelog-plugins.html Changelog-themes.html Themes.html
}


