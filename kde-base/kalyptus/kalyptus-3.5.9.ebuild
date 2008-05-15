# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalyptus/kalyptus-3.5.9.ebuild,v 1.2 2008/05/15 14:41:36 corsair Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE bindings generator for multiple languages."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc ~x86"
IUSE=""
DEPEND="dev-lang/perl"

PATCHES="${FILESDIR}/${P}-fix_makefile.patch"

MY_S="${WORKDIR}/${P}/${PN}"

# Weird build system, weirder errors.
# You're welcome to fix this in a better way --danarmak
# Still weird, but changed. :)
src_compile () {
	S="${MY_S}"
	cd "${S}"
	emake -f Makefile.cvs
	./configure --prefix=$(kde-config --prefix)
	emake
}

src_install() {
	S="${MY_S}"
	cd "${S}"
	emake install DESTDIR="$D"
}
