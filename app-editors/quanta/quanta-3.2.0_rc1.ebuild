# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.0_rc1.ebuild,v 1.1 2004/01/19 14:58:11 caleb Exp $

inherit kde

need-kde 3.2
S=${WORKDIR}/quanta-3.1.95

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/unstable/3.1.95/src/quanta-3.1.95.tar.bz2"
IUSE="doc"

DEPEND="doc? ( app-doc/quanta-docs )"

LICENSE="GPL-2"
KEYWORDS="~x86"

