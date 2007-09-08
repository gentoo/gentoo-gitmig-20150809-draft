# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/compositeproto/compositeproto-0.4.ebuild,v 1.4 2007/09/08 21:15:40 josejx Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Composite protocol headers"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 s390 sh ~sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}"
