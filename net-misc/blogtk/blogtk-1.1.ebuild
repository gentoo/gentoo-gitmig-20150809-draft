# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-1.1.ebuild,v 1.5 2007/07/02 14:59:23 peper Exp $

inherit eutils

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/BloGTK-${PV}.tar.bz2"
RESTRICT="mirror"
S="${WORKDIR}/BloGTK-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.0.0
	>=gnome-base/gconf-2.2.0
	>=dev-python/gnome-python-2
	dev-python/gnome-python-extras
	amd64? ( >=dev-python/gnome-python-2.6.1 )"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${PN}-1.1-destdir.patch
}

src_compile() {
	return
}

src_install() {
	make DESTDIR=${D} install || die "Unable to compile blogtk"
}
