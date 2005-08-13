# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.36.ebuild,v 1.3 2005/08/13 23:07:40 hansmi Exp $

inherit kde

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="doc xmms"

DEPEND="dev-lang/python
	xmms? ( media-sound/xmms )"

need-kde 3.2

src_compile() {
	# hack, until the configure script supports a switch
	use xmms || export ac_cv_have_xmms=no

	kde_src_compile
}

src_install() {
	kde_src_install

	newenvd ${FILESDIR}/karamba-env 99karamba

	keepdir /usr/share/karamba/themes /usr/share/karamba/bin

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r ${S}/examples
	fi
}
