# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ktoblzcheck/ktoblzcheck-1.24.ebuild,v 1.6 2010/11/03 12:27:02 ssuominen Exp $

EAPI=2

DESCRIPTION="Library to check account numbers and bank codes of German banks"
HOMEPAGE="http://ktoblzcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE="python"

RDEPEND="sys-apps/gawk
	sys-apps/grep
	python? ( >=dev-lang/python-2.5 )"
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable python)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
