# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/epplets/epplets-0.7.ebuild,v 1.10 2004/07/14 04:18:38 vapier Exp $

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/epplets-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="virtual/x11
	virtual/glut
	>=media-libs/imlib-1.9.10
	>=x11-wm/enlightenment-0.16.6
	media-sound/esound"

src_compile() {
	export EROOT=/usr
	export EBIN=/usr/bin
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
