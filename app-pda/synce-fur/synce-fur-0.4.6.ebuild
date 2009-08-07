# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-fur/synce-fur-0.4.6.ebuild,v 1.2 2009/08/07 01:31:00 mescalinum Exp $

EAPI=2

inherit eutils

MY_P="FUR-${PV}"

DESCRIPTION="FUSE based filesystem access to a connected SynCE device."
HOMEPAGE="http://www.synce.org"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="void-chmod"

DEPEND=">=app-pda/synce-0.14"
RDEPEND=">=app-pda/synce-0.14
	>=sys-fs/fuse-2.7.4"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-destdir.patch"
}

src_configure() {
	econf $(use_enable void-chmod)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc Changelog README.txt
	( cd docs ; dodoc $(ls -1 | fgrep -v COPYING.txt) )
}
