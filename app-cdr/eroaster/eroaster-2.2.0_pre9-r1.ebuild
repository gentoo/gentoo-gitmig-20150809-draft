# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.2.0_pre9-r1.ebuild,v 1.1 2005/04/05 12:01:04 pylon Exp $

inherit eutils

IUSE="xmms encode oggvorbis"

MY_P=${PF/_pre9-r1/-0.9a}

DESCRIPTION="ECLiPt Roaster: A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://www.eclipt.at/eroaster.php"
SRC_URI="mirror://sourceforge/eroaster/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/python-2.0
	>=dev-python/gnome-python-1.4.2
	app-cdr/cdrtools"

RDEPEND="${DEPEND}
	app-cdr/bchunk
	xmms? ( media-sound/xmms )
	encode? ( media-sound/lame
		media-sound/sox )
	oggvorbis? ( media-sound/vorbis-tools )
	app-cdr/cdrdao"

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

