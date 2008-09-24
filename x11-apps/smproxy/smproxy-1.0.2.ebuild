# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/smproxy/smproxy-1.0.2.ebuild,v 1.7 2008/09/24 10:09:39 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Session Manager Proxy"
KEYWORDS="~amd64 arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libXt
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
