# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>

A=emacs-20.7.tar.gz
S=${WORKDIR}/emacs-20.7
DESCRIPTION="An incredibly powerful, extensible text editor (X11/Motif version)"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/emacs/emacs-20.7.tar.gz"
HOMEPAGE="http://www.gnu.org/software/emacs"
RDEPEND=">=sys-libs/ncurses-4.0
         >=x11-libs/openmotif-2.1.30
         !app-editors/emacs-nogui
         !app-editors/emacs-x11"

DEPEND=">=sys-libs/ncurses-4.0
        >=x11-libs/openmotif-2.1.30
        >=sys-devel/gettext-0.10.35"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --libexecdir=/usr/lib --host=${CHOST} \
        --with-x-toolkit=motif --with-x
    try make
}

src_install () {
    cd ${S}
    try make prefix=${D}/usr/X11R6 libexecdir=${D}/usr/X11R6/lib install
    dodoc BUGS ChangeLog README
    gzip -9 ${D}/usr/X11R6/info/*
}

