# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp32ogg/mp32ogg-0.11.ebuild,v 1.1 2003/05/12 19:45:57 avenj Exp $


DESCRIPTION="A perl script to convert MP3 files to Ogg Vorbis files."

HOMEPAGE="http://faceprint.com/code/"

SRC_URI="ftp://ftp.faceprint.com/pub/software/scripts/mp32ogg"

LICENSE="Artistic"

SLOT="0"

KEYWORDS="~x86"

DEPEND="dev-perl/MP3-Info
	dev-perl/String-ShellQuote"

S=${WORKDIR}/

src_unpack(){
	cp ${DISTDIR}/${A} ${S}
}

src_install() {
	dobin mp32ogg
}
