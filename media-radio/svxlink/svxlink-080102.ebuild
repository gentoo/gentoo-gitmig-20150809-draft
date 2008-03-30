# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/svxlink/svxlink-080102.ebuild,v 1.1 2008/03/30 15:11:11 pylon Exp $

EAPI=1

inherit kde-functions

DESCRIPTION="Multi Purpose Voice Services System, including Qtel for EchoLink"
HOMEPAGE="http://svxlink.sourceforge.net/"
SRC_URI="mirror://sourceforge/svxlink/svxlink-070415.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/tcl
	media-sound/gsm
	x11-libs/qt:3"
DEPEND="${RDEPEND}
	 dev-libs/libsigc++:1.2"

S=${WORKDIR}/${PN}

src_compile() {
	epatch "${FILESDIR}"/kde.patch
	set-kdedir
	emake -j1 || die "emake failed"
}

src_install() {
	emake \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
}
