# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-fu/gtk2-fu-0.01.ebuild,v 1.1 2004/11/26 20:46:35 dams Exp $

IUSE=""

MY_P=${PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="gtk2-fu is a layer on top of perl gtk2, that brings power, simplicity and speed of development"
HOMEPAGE="http://libconf.net/gtk2-fu/"
SRC_URI="http://libconf.net/gtk2-fu/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="dev-perl/gtk2-perl"

src_compile() {
	emake || die "make failed"
}

src_install() {
	einstall PREFIX=${D}/usr
}
