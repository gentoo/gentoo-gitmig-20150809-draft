# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/galan/galan-0.2.13d.ebuild,v 1.4 2003/09/08 07:09:44 msterret Exp $


DESCRIPTION="gAlan - Graphical Audio Language"
SRC_URI="mirror://sourceforge/galan/${P}.tar.gz"
HOMEPAGE="http://galan.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

IUSE="oggvorbis alsa opengl esd"

S=${WORKDIR}/${P}
DEPEND=">=x11-libs/gtk+-1.2*
        media-libs/gdk-pixbuf
	oggvorbis? ( >=media-sound/vorbis-tools-1.0 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
	opengl? ( >=x11-libs/gtkglarea-1.2* )
	esd? ( media-sound/esound )
        media-libs/liblrdf
        media-libs/ladspa-sdk
        media-libs/audiofile
        media-libs/libsndfile"


src_unpack() {
	unpack ${A}
	mv galan-0.2.13 galan-0.2.13d
}

src_compile() {
	econf || die "configure failed"
	emake || die "build failed"
}

src_install() {
    einstall || dies "install failed"
}

DOC="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO doc/"

