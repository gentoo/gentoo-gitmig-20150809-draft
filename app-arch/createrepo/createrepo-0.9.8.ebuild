# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/createrepo/createrepo-0.9.8.ebuild,v 1.2 2010/06/16 20:45:25 patrick Exp $

EAPI="2"

DESCRIPTION="Creates a common metadata repository"
HOMEPAGE="http://createrepo.baseurl.org/"
SRC_URI="http://createrepo.baseurl.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	>=dev-python/urlgrabber-2.9.0
	>=app-arch/rpm-4.0[python]
	dev-libs/libxml2[python]
	>=sys-apps/yum-3.2.23"

src_prepare() {
	sed -i \
		-e '/^sysconfdir/s:=.*/:=/:' \
		Makefile
}

src_compile() { :; }

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog README
}
