# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/koctave/koctave-0.65.ebuild,v 1.1 2004/03/24 17:30:49 jhuebel Exp $

inherit kde
need-kde 3

IUSE=""

DESCRIPTION="A KDE GUI for Octave numerical computing system"
HOMEPAGE="http://bubben.homelinux.net/~matti/koctave/"
SRC_URI="http://bubben.homelinux.net/~matti/koctave/${PN}3-0.65.tar.bz2"
S=${WORKDIR}/${PN}3-${PV}

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND="virtual/glibc
	app-sci/octave
	kde-base/kdebase"
