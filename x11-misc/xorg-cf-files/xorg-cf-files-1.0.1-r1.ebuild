# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xorg-cf-files/xorg-cf-files-1.0.1-r1.ebuild,v 1.3 2006/04/09 14:30:40 flameeyes Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Old Imake-related build files"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install

	echo "#define ProjectRoot /usr" > ${D}/usr/$(get_libdir)/X11/config/host.def
}
