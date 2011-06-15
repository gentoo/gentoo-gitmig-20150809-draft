# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Encode/perl-Encode-2.420.0-r1.ebuild,v 1.2 2011/06/15 06:26:08 naota Exp $

DESCRIPTION="Virtual for Encode"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~m68k ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.14.0 ~perl-core/Encode-${PV} )"
