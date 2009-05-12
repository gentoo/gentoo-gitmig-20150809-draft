# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXCalibrate/libXCalibrate-0.1_pre20081207-r1.ebuild,v 1.1 2009/05/12 09:05:10 remi Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"
inherit x-modular

LICENSE="GPL-2"
DESCRIPTION="X.Org Calibrate client-side protocol library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xcalibrateproto
	x11-proto/xextproto"

MY_PV="${PV#*_pre}"
#SRC_URI="http://www.angstrom-distribution.org/unstable/sources/${PN}_anoncvs.freedesktop.org__${MY_PV}.tar.gz"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.bz2"
IUSE=""
S="${WORKDIR}/${PN}"
