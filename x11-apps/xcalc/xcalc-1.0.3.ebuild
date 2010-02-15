# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcalc/xcalc-1.0.3.ebuild,v 1.6 2010/02/15 19:12:00 josejx Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="scientific calculator for X"

KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}"
