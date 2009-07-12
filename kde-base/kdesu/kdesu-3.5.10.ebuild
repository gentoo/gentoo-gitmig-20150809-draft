# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesu/kdesu-3.5.10.ebuild,v 1.7 2009/07/12 09:39:20 armin76 Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="KDE: gui for su(1)"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

src_compile() {
	kde-meta_src_compile
}
