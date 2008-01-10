# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dnotify/dnotify-0.18.0.ebuild,v 1.9 2008/01/10 10:40:22 vapier Exp $

inherit eutils

DESCRIPTION="Execute a command when the contents of a directory change"
HOMEPAGE="http://directory.fsf.org/project/dnotify/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc -sparc x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-nls.patch
}

src_compile() {
	econf $(use_enable nls) || die "failed to configure"
	emake || die "failed to make"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO NEWS README
}
