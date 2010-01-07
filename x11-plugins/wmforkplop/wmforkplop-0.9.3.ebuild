# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmforkplop/wmforkplop-0.9.3.ebuild,v 1.2 2010/01/07 16:00:12 fauli Exp $

DESCRIPTION="monitors the forking activity of the kernel and most active processes"
HOMEPAGE="http://hules.free.fr/wmforkplop"
SRC_URI="http://hules.free.fr/wmforkplop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-solaris"
IUSE=""

DEPEND="gnome-base/libgtop
	media-libs/imlib2"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
