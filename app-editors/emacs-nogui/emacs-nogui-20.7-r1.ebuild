# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>

A=emacs-20.7.tar.gz
S=${WORKDIR}/emacs-20.7
DESCRIPTION="An incredibly powerful, extensible text editor (X11/Motif version)"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/emacs/emacs-20.7.tar.gz"
HOMEPAGE="http://www.gnu.org/software/emacs"

RDEPEND=">=sys-libs/ncurses-5.2
         !app-editors/emacs-motif
         !app-editors/emacs-x11"

DEPEND=">=sys-libs/ncurses-5.2
        >=sys-devel/gettext-0.10.35"

src_compile() {

    try ./configure --prefix=/usr --libexecdir=/usr/lib --host=${CHOST} \
        --mandir=/usr/share/man --infodir=/usr/share/info --without-x
    try make

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

