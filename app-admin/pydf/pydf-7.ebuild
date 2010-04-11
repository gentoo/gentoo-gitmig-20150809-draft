# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pydf/pydf-7.ebuild,v 1.5 2010/04/11 13:34:41 nixnut Exp $

EAPI=2
inherit eutils

MY_P=${P/-/_}
DESCRIPTION="Enhanced df with colors"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

src_prepare() {
	epatch "$FILESDIR"/pydf-bw.patch
}

src_compile() { :; }

src_install() {
	dobin pydf || die "dobin failed"
	insinto /etc
	doins pydfrc || die "doins failed"
	doman pydf.1
	dodoc README
}
