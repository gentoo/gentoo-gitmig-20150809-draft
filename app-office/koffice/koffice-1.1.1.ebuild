# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.1.1.ebuild,v 1.12 2002/07/26 16:12:53 danarmak Exp $

inherit kde-base || die

need-kde 2.2.2

DESCRIPTION="KDE ${PV} - KOffice"

HOMEPAGE="http://www.koffice.org/"

# turns out kde.org.eclass doesn't work here
SRC_PATH="kde/stable/${P}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"


KEYWORDS="x86 ppc"

DEPEND="$DEPEND
	>=dev-lang/python-2.0-r5"
#	>=sys-devel/automake-1.4
#	>=sys-devel/autoconf-1.13"

src_unpack() {
	base_src_unpack all patch
}

src_compile() {

    myconf="$myconf --enable-all"
    myconf="$myconf --with-extra-libs=/usr/lib/python2.2/config"
    kde_src_compile myconf configure
    export LIBPYTHON="`python-config --libs`"

    #the dir kchar/kdchart cannot be compiled with the -fomit-frame-pointer flag present
    kde_remove_flag kchart/kdchart -fomit-frame-pointer
	
    kde_src_compile make
	
}
