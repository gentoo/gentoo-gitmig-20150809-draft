# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/corkscrew/corkscrew-2.0.ebuild,v 1.1 2002/10/21 16:31:06 mjc Exp $

# comprehensive list of any and all USE flags leveraged in the build, 
# with the exception of any ARCH specific flags, i.e. ppc sparc sparc64
# x86 alpha - this is a required variable
IUSE=""
DESCRIPTION="Cantus is an easy to use tool for tagging and renaming MP3 and OGG/Vorbis files. It has many features including mass tagging and renaming of MP3s, the ability to generate a tag out of the filename, filter definitions for renaming, recursive actions, CDDB (Freedb) lookup (no CD needed), copy between ID3V1 and ID3V2 tags, and a lot more."
HOMEPAGE="http://www.agroman.net/corkscrew"
SRC_URI="http://www.agroman.net/corkscrew/${P}.tar.gz"
LICENSE="gpl"
SLOT="0"
KEYWORDS="~x86"
DEPEND="net-misc/openssh"
RDEPEND="$DEPEND"
S="${WORKDIR}/${P}"

src_compile() {
	cd ${S}	
	econf || die "configure failed"
	make || die "make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README
	dodoc INSTALL
	dodoc COPYING
	dodoc AUTHORS
	dodoc ChangeLog
}
