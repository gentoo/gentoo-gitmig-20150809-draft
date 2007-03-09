# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/sheepshaver/sheepshaver-20060514.ebuild,v 1.1 2007/03/09 12:06:51 armin76 Exp $

inherit eutils

DESCRIPTION="A MacOS run-time environment that allows you to run classic MacOS applications"
HOMEPAGE="http://gwenole.beauchesne.info/projects/sheepshaver/"
SRC_URI="http://gwenole.beauchesne.info/projects/${PN}/files/SheepShaver-2.3-0.${PV}.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gtk esd"

DEPEND="gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )"

S="${WORKDIR}/SheepShaver-2.3/src/Unix"

src_install() {
	dohtml doc/Linux/*

	emake DESTDIR="${D}" install || die "emake install failed"
}
