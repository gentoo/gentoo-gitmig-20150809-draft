# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.1.0-r1.ebuild,v 1.4 2003/06/29 16:01:56 aliz Exp $

IUSE="xmms encode oggvorbis"

S="${WORKDIR}/${P}"
DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eroaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/eroaster/${P}.tar.gz"  

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc "

# cdrecord and mkisofs are needed or configure fails
DEPEND=">=dev-lang/python-2.0
	=dev-python/gnome-python-1.4*
	app-cdr/cdrtools"

# xmms, lame and vorbis-tools are just runtime conveniences
# not a bulild dep.
RDEPEND="${DEPEND}
	app-cdr/bchunk
	xmms? ( media-sound/xmms )
	encode? ( media-sound/lame
		media-sound/sox )
	oggvorbis? ( media-sound/vorbis-tools )"

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

