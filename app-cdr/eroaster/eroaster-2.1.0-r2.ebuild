# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.1.0-r2.ebuild,v 1.5 2004/03/30 00:27:55 mr_bones_ Exp $

inherit eutils

IUSE="xmms encode oggvorbis"

DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eclipt.uni-klu.ac.at/eroaster.php"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

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

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

