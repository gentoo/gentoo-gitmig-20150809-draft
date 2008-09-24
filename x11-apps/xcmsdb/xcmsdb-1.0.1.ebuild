# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcmsdb/xcmsdb-1.0.1.ebuild,v 1.8 2008/09/24 10:12:44 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Device Color Characterization utility for X Color Management System"
KEYWORDS="~amd64 arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
