# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.1.0.ebuild,v 1.5 2002/08/06 19:58:32 naz Exp $

DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eroaster.sourceforge.net"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/eroaster/${P}.tar.gz"  

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

# cdrecord and mkisofs are needed or configure fails
DEPEND=">=dev-lang/python-2.0
	>=dev-python/gnome-python-1.4
	app-cdr/cdrtools"

# xmms here is only used in runtime
# not a bulild dep.
RDEPEND="${DEPEND}
	xmms? ( media-sound/xmms )"

S=${WORKDIR}/${P}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}

pkg_postinst() {
	einfo
	einfo "The following binaries are needed to make full use of this program:"
	einfo
	einfo "mpg123   For converting MP3s to WAVs and playing MP3s"
	einfo "sox      For converting MP3s to WAVs"
	einfo "xmms     For playing MP3s"
	einfo "bchunk   For converting BIN/CUE to ISO"
	einfo "lame     For Encoding MP3s"
	einfo "ogginfo  For Getting OGG ID3 information"
	einfo "ogg123   For converting OGGs to WAVs"
	einfo
}
