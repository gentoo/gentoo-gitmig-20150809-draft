# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Kalen Petersen <kalenp@cs.washington.edu>
# /home/cvsroot/gentoo-x86/media-sound/mp32ogg/mp32ogg-0.10.ebuild,v 1.0 2001/03/10 12:55:37 achim Exp

P=mp32ogg
A=${P}
S=${WORKDIR}
DESCRIPTION="A perl script for automating mp3 to ogg vorbis format conversion"
SRC_URI="http://ftp.faceprint.com/pub/software/scripts/${A}"
HOMEPAGE="http://faceprint.com/software.phtml"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/MP3-Info-0.91
	>=dev-perl/String-ShellQuote-1.00
	>=media-sound/mpg321-0.1.5
	>=vorbis-tools/vorbis-tools-1.0_rc2"

src_compile () {

	chmod 755 mp32ogg
}

src_install () {

	insinto /usr/bin
	doins /usr/portage/distfiles/mp23ogg.dll

}



