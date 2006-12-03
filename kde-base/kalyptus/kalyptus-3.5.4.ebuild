# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalyptus/kalyptus-3.5.4.ebuild,v 1.8 2006/12/03 18:51:14 corsair Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE bindings generator for multiple languages."
KEYWORDS="amd64 ppc ppc64 sparc x86"
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