# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Chris Arndt <arndtc@mailandnews.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.5 2001/07/24 22:30:35 lordjoe Exp
# $Header: /var/cvsroot/gentoo-x86/incoming/vsound-0.5.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $



#inside ${WORKDIR}
A=${PN}-0.5.tar.gz
S=${WORKDIR}/${PN}-0.5
DESCRIPTION="VSound is a sort of like a virtual audio loopback cable for 
RealAudio to wave file convertions."
SRC_URI="http://www.zip.com.au/~erikd/vsound/${A}"
HOMEPAGE="http://www.zip.com.au/~erikd/vsound/"

#build-time dependencies
DEPEND=">=media-sound/sox-12.17.1"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND="$DEPEND"


src_compile() {

    try ./configure --infodir=/usr/share/info --mandir=/usr/share/man 
--host=${CHOST}

    try emake
}


src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING Changelog INSTALL NEWS README README.original
}

