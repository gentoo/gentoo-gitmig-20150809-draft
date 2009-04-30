# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdbedizzy/xdbedizzy-1.0.2.ebuild,v 1.4 2009/04/30 23:07:46 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xdbedizzy application"
KEYWORDS="~amd64 arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}"
CONFIGURE_OPTIONS="--disable-xprint"
