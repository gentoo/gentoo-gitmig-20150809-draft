# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.43.ebuild,v 1.1 2005/02/26 05:28:38 dragonheart Exp $

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc
	virtual/libpcap"
#DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR=${D} install || die "install failed"
	dodoc doc/*.txt
}
