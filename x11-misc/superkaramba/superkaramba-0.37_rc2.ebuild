# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.37_rc2.ebuild,v 1.4 2006/01/08 02:13:30 carlo Exp $

inherit kde

MY_P="${P/_rc/-RC}"

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc xmms"

DEPEND="dev-lang/python
	xmms? ( media-sound/xmms )
	( !kde-base/superkaramba !>=kde-base/kdeutils-3.5 )"

S="${WORKDIR}/${PN}"

need-kde 3.2

src_compile() {
	local myconf="$(use_with xmms)"

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
