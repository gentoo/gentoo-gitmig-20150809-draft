# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-sword/kio-sword-0.2.ebuild,v 1.1 2006/04/28 00:29:23 squinky86 Exp $

inherit kde eutils

DESCRIPTION="a nice kio handler to sword"
HOMEPAGE="http://lukeplant.me.uk/kio-sword/"
SRC_URI="http://lukeplant.me.uk/kio-sword/downloads/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=app-text/sword-1.5.8"

S=${WORKDIR}/${PN/-/_}-${PV}

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch sword_1_5_8_fix.patch
}

pkg_postinst() {
	einfo "It is recommended that you have modules installed for sword."
	einfo "Gentoo provides the \"sword-modules\" package for convenience:"
	einfo "\temerge sword-modules"
}
