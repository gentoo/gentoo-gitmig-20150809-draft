# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.6.1.ebuild,v 1.6 2002/08/23 16:55:27 danarmak Exp $
inherit kde-base || die

need-kde 3

DESCRIPTION="ktail monitors multiple files and/or command output in one window."
SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.bz2"
HOMEPAGE="http://www.franken.de/users/duffy1/rjakob/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {

    kde_src_compile myconf configure
    cd $S/ktail
    mv Makefile Makefile.orig
    sed -e 's:kde_widgetdir = ${exec_prefix}/lib/kde3/plugins/designer:kde_widgetdir = ${kde_libs_prefix}/lib/kde3/plugins/designer:' Makefile.orig > Makefile
    cd $S
    kde_src_compile make

}
