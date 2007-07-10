# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-ivtv/Video-ivtv-0.12.ebuild,v 1.5 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Video::ivtv perl module, for use with ivtv-ptune"
HOMEPAGE="http://ivtv.sourceforge.net"
SRC_URI="mirror://sourceforge/ivtv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

export OPTIMIZE="$CFLAGS"
mydoc="README COPYING"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
