# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.5.0.ebuild,v 1.1 2004/11/26 03:53:21 bcowan Exp $

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/xfmedia/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	>=xfce-base/xfce4-base-4.1.90
	media-libs/xine-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS INSTALL NEWS README README.remote TODO
}
