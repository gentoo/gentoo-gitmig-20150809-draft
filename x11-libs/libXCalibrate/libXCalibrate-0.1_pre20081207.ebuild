# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXCalibrate/libXCalibrate-0.1_pre20081207.ebuild,v 1.8 2009/04/15 14:33:22 armin76 Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"
inherit x-modular

LICENSE="GPL-2"
DESCRIPTION="X.Org Calibrate client-side protocol library"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND="x11-proto/xcalibrateproto"
DEPEND="${RDEPEND}"

MY_PV="${PV#*_pre}"
#SRC_URI="http://www.angstrom-distribution.org/unstable/sources/${PN}_anoncvs.freedesktop.org__${MY_PV}.tar.gz"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.bz2"
IUSE="${IUSE}"
S="${WORKDIR}/${PN}"
