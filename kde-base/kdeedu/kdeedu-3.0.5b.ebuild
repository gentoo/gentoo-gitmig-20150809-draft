# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.0.5b.ebuild,v 1.4 2004/01/19 03:48:01 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE $PV - educational apps"
KEYWORDS="x86 ppc ~alpha sparc"

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/klettres/klettres
}

src_compile() {
	kde_src_compile myconf configure

	# build fails with -fomit-frame-pointer optimization in kgeo
	kde_remove_flag kgeo -fomit-frame-pointer
	kde_remove_flag kgeo/kgeo -fomit-frame-pointer

	kde_src_compile make
}
