# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-21.0.103.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An incredibly powerful, extensible text editor"
SRC_URI="ftp://ftp.eecs.umich.edu/pub/NetBSD/packages/distfiles/LOCAL_PORTS/${A}"
HOMEPAGE="http://www.gnu.org/software/emacs"

DEPEND=">=sys-libs/ncurses-5.2
        X? ( virtual/x11
             media-libs/libungif-4.1.0
             media-libs/jpeg-6b-r2
             media-libs/tiff-3.5.5-r3
             media-libs/libpng-1.0.9 )
        motif? ( >=x11-libs/openmotif-2.1.30 )
        nls? ( >=sys-devel/gettext-0.10.35 )"

PROVIDE="virtual/emacs"

src_compile() {
    local myconf
	
    if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
    fi 
    if [ "`use X`" ] ; then
		myconf="${myconf} --with-x --with-xpm --with-jpeg --with-tiff --with-gif --with-png"
	else
		myconf="${myconf} --without-x"
    fi
    if [ "`use motif`" ] ; then
		myconf="${myconf} --with-x-toolkit=motif"
    fi
	
    try ./configure --prefix=/usr --libexecdir=/usr/lib --host=${CHOST} \
        --mandir=/usr/share/man --infodir=/usr/share/info ${myconf}
	
    try make ${MAKEOPTS}
}

src_install () {
    try make prefix=${D}/usr libexecdir=${D}/usr/lib \
	mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    cd ${D}/usr/share/info
    rm dir
    for i in *
    do
        mv ${i%.info} $i.info
    done
    dodoc BUGS ChangeLog README
}





