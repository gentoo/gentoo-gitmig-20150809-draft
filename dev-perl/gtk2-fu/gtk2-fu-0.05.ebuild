# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-fu/gtk2-fu-0.05.ebuild,v 1.1 2005/01/09 22:54:47 dams Exp $

IUSE=""

MY_P=Gtk2Fu-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="gtk2-fu is a layer on top of perl gtk2, that brings power, simplicity and speed of development"
HOMEPAGE="http://libconf.net/gtk2-fu/"
SRC_URI="http://libconf.net/gtk2-fu/download/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="dev-perl/gtk2-perl"

src_compile() {
perl Makefile.PL || die "make failed"
make || die "make failed"
}

src_install() {
	make install DESTDIR=${D}
}
