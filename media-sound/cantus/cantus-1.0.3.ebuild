# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.0.3.ebuild,v 1.1 2002/10/20 18:02:47 mjc Exp $

# comprehensive list of any and all USE flags leveraged in the build, 
# with the exception of any ARCH specific flags, i.e. ppc sparc sparc64
# x86 alpha - this is a required variable
IUSE=""
DESCRIPTION="Cantus is an easy to use tool for tagging and renaming MP3 and OGG/Vorbis files. It has many features including mass tagging and renaming of MP3s, the ability to generate a tag out of the filename, filter definitions for renaming, recursive actions, CDDB (Freedb) lookup (no CD needed), copy between ID3V1 and ID3V2 tags, and a lot more."
HOMEPAGE="http://software.manicsadness.com/?site=project&project=1"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step2/releases/cantus/cantus-1.03-1.tar.gz"
LICENSE="gpl"
SLOT="0"
KEYWORDS="~x86"
DEPEND="x11-libs/gtk+-1.2*
	vorbis? media-libs/libvorbis
	vorbis? media-libs/libogg"
RDEPEND="$DEPEND"
S="${WORKDIR}/${PN}-1.03"

src_compile() {
	cd ${S}	
	econf || die "configure failed"
	make || die "make failed"
}

src_install() {
	einstall || die "Install failed"
}
