# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/selflinux/selflinux-0.12.1.ebuild,v 1.3 2012/07/29 16:55:35 armin76 Exp $

IUSE=""

MY_P="SelfLinux-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="german-language hypertext tutorial about Linux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-html.tar.gz"
HOMEPAGE="http://selflinux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

src_install() {
	dodir /usr/share/doc/selflinux
	cp -R * "${D}"/usr/share/doc/selflinux
}
