# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-2.0.0.ebuild,v 1.1 2003/08/31 13:27:05 liquidx Exp $

inherit gnome2

DESCRIPTION="Gnome Desktop Sound Effects Package"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	return
}	

src_install() {
	make prefix=${D}/usr install || die "installed failed"
	dodoc README
}
