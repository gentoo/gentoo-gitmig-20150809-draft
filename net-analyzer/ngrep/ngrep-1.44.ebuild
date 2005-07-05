# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.44.ebuild,v 1.1 2005/07/05 13:34:29 dragonheart Exp $

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="ipv6 pcre"

DEPEND="virtual/libc
	virtual/libpcap
	pcre? ( dev-libs/libpcre )"

src_compile() {
	econf $(use_enable pcre) $(use_enable ipv6) || die "configure problem"
	emake || die "make problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
	dodoc doc/*.txt
}
