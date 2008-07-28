# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-user-dirs/xdg-user-dirs-0.10.ebuild,v 1.3 2008/07/28 03:55:12 mr_bones_ Exp $

DESCRIPTION="xdg-user-dirs is a tool to help manage 'well known' user directories"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/xdg-user-dirs"
SRC_URI="http://user-dirs.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO
}
