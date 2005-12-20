# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xmms-remote/gaim-xmms-remote-1.9_beta1.ebuild,v 1.1 2005/12/20 22:49:43 vanquirius Exp $

inherit debug

MY_P="${P/_/}"
DESCRIPTION="control XMMS from within Gaim"
HOMEPAGE="http://guifications.sourceforge.net/Gaim-XMMS-Remote/"
SRC_URI="mirror://sourceforge/guifications/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=net-im/gaim-2.0.0_beta1-r1
	>=media-sound/xmms-1.2.10-r14"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README VERSION
}
