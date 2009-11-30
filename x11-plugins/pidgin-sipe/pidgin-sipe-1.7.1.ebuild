# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-sipe/pidgin-sipe-1.7.1.ebuild,v 1.1 2009/11/30 14:09:09 lack Exp $

DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="$DEPEND"

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc ChangeLog NEWS TODO || die "dodoc failed"
}
