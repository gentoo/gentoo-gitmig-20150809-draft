# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.2.0_pre6.ebuild,v 1.2 2003/10/19 23:47:58 lanius Exp $

IUSE="xmms encode oggvorbis"

MY_PV=${PV/_/-}
MY_PV=${MY_PV/pre/0.}

DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eclipt.uni-klu.ac.at/eroaster.php"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
S="${WORKDIR}/${PN}-${MY_PV}"

# cdrecord and mkisofs are needed or configure fails
DEPEND=">=dev-lang/python-2.0
	>=dev-python/gnome-python-1.4.2
	app-cdr/cdrtools"

# xmms, lame and vorbis-tools are just runtime conveniences
# not a bulild dep.
RDEPEND="${DEPEND}
	app-cdr/bchunk
	xmms? ( media-sound/xmms )
	encode? ( media-sound/lame
		media-sound/sox )
	oggvorbis? ( media-sound/vorbis-tools )
	media-sound/zinf"

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

