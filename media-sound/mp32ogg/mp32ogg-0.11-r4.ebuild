# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp32ogg/mp32ogg-0.11-r4.ebuild,v 1.1 2005/01/01 15:59:45 chainsaw Exp $

inherit eutils
IUSE=""

DESCRIPTION="A perl script to convert MP3 files to Ogg Vorbis files."

HOMEPAGE="http://faceprint.com/code/"
SRC_URI="ftp://ftp.faceprint.com/pub/software/scripts/mp32ogg"

LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND=""
RDEPEND="virtual/mpg123
	dev-perl/MP3-Info
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools"

S=${WORKDIR}/

src_unpack(){
	cp ${DISTDIR}/${A} ${S}
	epatch ${FILESDIR}/${PF}-mpg321.patch
	epatch ${FILESDIR}/${PF}-quality.patch
}

src_install() {
	dobin mp32ogg
}
