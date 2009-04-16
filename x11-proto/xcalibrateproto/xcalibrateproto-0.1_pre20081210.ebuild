# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xcalibrateproto/xcalibrateproto-0.1_pre20081210.ebuild,v 1.9 2009/04/16 03:21:43 jer Exp $

# git clone git://anongit.freedesktop.org/git/xorg/proto/calibrateproto
# rm -rf calibrateproto/.git
# mv calibrateproto calibrateproto-`date -u +%Y%m%d`
# tar jcvf calibrateproto-`date -u +%Y%m%d`.tar.bz2 calibrateproto-`date -u +%Y%m%d`/

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"
inherit x-modular

MY_PN=${PN/x/}
MY_PV="${PV#*_pre}"

DESCRIPTION="Touchscreen calibration protocol"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
LICENSE="GPL-2"
DEPEND="${RDEPEND}"
RDEPEND=""
SRC_URI="mirror://gentoo/${MY_PN}-${MY_PV}.tar.bz2"
IUSE="${IUSE}"
S="${WORKDIR}/${MY_PN}-${MY_PV}"
