# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-ivtv/Video-ivtv-0.13.ebuild,v 1.3 2005/07/29 16:01:45 pvdabeel Exp $

inherit perl-module

DESCRIPTION="Video::ivtv perl module, for use with ivtv-ptune"
HOMEPAGE="http://ivtv.sourceforge.net"
SRC_URI="mirror://sourceforge/ivtv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

export OPTIMIZE="$CFLAGS"
mydoc="README Changes COPYING"
