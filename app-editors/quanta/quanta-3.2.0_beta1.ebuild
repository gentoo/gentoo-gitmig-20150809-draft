# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.0_beta1.ebuild,v 1.3 2003/11/30 14:50:36 caleb Exp $

inherit kde-base

need-kde 3.2
S=${WORKDIR}/quanta-3.1.93

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/unstable/3.1.93/src/quanta-3.1.93.tar.bz2
	doc? ( app-doc/quanta-docs )"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="doc"

src_install() {
	kde_src_install
}
