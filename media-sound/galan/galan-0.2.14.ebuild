# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/galan/galan-0.2.14.ebuild,v 1.9 2004/03/27 03:02:26 eradicator Exp $

inherit eutils

DESCRIPTION="gAlan - Graphical Audio Language"
HOMEPAGE="http://galan.sourceforge.net/"
SRC_URI="mirror://sourceforge/galan/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86 ~sparc"

IUSE="oggvorbis alsa opengl esd"

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

DOC="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO doc/"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-alsalib-fix.patch || die "Alsalib patch failed"
}

src_install() {
	einstall || dies "install failed"
	dodoc ${DOC}
}
