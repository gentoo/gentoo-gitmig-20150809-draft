# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Chris Arndt <arndtc@mailandnews.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.5 2001/07/24 22:30:35 lordjoe Exp
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-0.5.2.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $



#inside ${WORKDIR}
A=${PN}-0.5.2.tar.gz
S=${WORKDIR}/${PN}-0.5.2
DESCRIPTION="Glame is an audio file editing utility."
SRC_URI="http://download.sourceforge.net/glame/${A}"
HOMEPAGE="http://glame.sourceforge.net/glame/"

#build-time dependencies
DEPEND=">=dev-util/guile-1.4-r3
         >=gnome-base/libxml-1.8.14
         >=media-libs/audiofile-0.2.1"


#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND="$DEPEND"


src_compile() {

    try ./configure --infodir=/usr/share/info --mandir=/usr/share/man 
--host=${CHOST}

    try emake
}


src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS COPYING CREDITS Changelog INSTALL MAINTAINERS NEWS 
README TODO
}

