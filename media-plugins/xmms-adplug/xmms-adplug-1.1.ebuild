# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-adplug/xmms-adplug-1.1.ebuild,v 1.1 2004/07/20 14:21:01 spock Exp $

MY_PN="adplug-xmms"

DESCRIPTION="A plug-in that adds support for the AdLib music files to XMMS"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/adplug/${MY_PN}-${PV}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-libs/adplug-1.4.1
	media-sound/xmms"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
