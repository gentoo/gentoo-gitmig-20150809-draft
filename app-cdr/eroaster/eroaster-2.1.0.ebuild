# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.1.0.ebuild,v 1.16 2003/09/05 22:57:44 msterret Exp $

IUSE="xmms"

S=${WORKDIR}/${P}
DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eroaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/eroaster/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

# cdrecord and mkisofs are needed or configure fails
DEPEND=">=dev-lang/python-2.0
	>=dev-python/gnome-python-1.4
	app-cdr/cdrtools"

# xmms, lame and vorbis-tools are just runtime conveniences
# not a bulild dep.
RDEPEND="${DEPEND}
	xmms? ( media-sound/xmms )
	encode? ( media-sound/lame )
	oggvorbis? ( media-sound/vorbis-tools )"

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

pkg_postinst() {
	einfo "The following binaries are needed to make full use of this program:"
	einfo
	einfo "mpg123   For converting MP3s to WAVs and playing MP3s"
	einfo "sox      For converting MP3s to WAVs"
	[ -z "`use xmms`" ]	&& einfo "xmms     For playing MP3s"
	einfo "bchunk   For converting BIN/CUE to ISO"
	[ -z "`use encode`" ]	&& einfo "lame     For Encoding MP3s"

	if [ -z "`use oggvorbis`" ]
	then
		einfo "ogginfo  For Getting OGG ID3 information"
		einfo "ogg123   For converting OGGs to WAVs"
	fi
}
