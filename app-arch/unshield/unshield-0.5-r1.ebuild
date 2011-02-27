# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unshield/unshield-0.5-r1.ebuild,v 1.4 2011/02/27 10:13:09 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="InstallShield CAB file extractor"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

RDEPEND=">=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-amd64.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
