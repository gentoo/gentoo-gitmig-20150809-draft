# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xman/xman-1.1.0.ebuild,v 1.5 2009/12/27 17:50:12 josejx Exp $

inherit x-modular

DESCRIPTION="Manual page display program for the X Window System"

KEYWORDS="amd64 ~arm ~hppa ~mips ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}"
