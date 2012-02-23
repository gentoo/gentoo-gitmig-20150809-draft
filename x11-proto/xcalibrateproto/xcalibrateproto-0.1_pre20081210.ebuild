# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xcalibrateproto/xcalibrateproto-0.1_pre20081210.ebuild,v 1.12 2012/02/23 18:31:47 scarabeus Exp $

EAPI=4

MY_P="${PN/x/}-${PV#*_pre}"

inherit xorg-2

DESCRIPTION="Touchscreen calibration protocol"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
