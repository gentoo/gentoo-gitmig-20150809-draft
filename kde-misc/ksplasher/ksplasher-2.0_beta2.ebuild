# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksplasher/ksplasher-2.0_beta2.ebuild,v 1.1 2009/11/11 01:05:42 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="a KSplashX engine (KDE4) Splash Screen Creator"
HOMEPAGE="http://ksplasher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}x${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging
	dev-python/PyQt4"

S=${WORKDIR}/${PN}x

src_install() {
	dobin ksplasherx || die
	insinto /usr/share/ksplasherx
	doins -r src || die
	doicon ksicon.png
	make_desktop_entry ${PN}x KSplasherX ksicon "Qt;KDE;Graphics"
	dodoc README
}
