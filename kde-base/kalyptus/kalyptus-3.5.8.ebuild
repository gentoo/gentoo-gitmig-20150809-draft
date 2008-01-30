# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalyptus/kalyptus-3.5.8.ebuild,v 1.4 2008/01/30 17:23:24 ranger Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=${PV}
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE bindings generator for multiple languages."
KEYWORDS="~alpha amd64 ~ia64 ~ppc ppc64 ~sparc x86"
IUSE=""
DEPEND="dev-lang/perl"

S="${S}/kalyptus"

# Weird build system, weirder errors.
# You're welcome to fix this in a better way --danarmak
# Still weird, but changed. :)
src_compile () {
	make -f Makefile.cvs
	./configure --prefix=$(kde-config --prefix)
	make
}

src_install() {
	make install DESTDIR="$D"
}
