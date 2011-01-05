# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/haveged/haveged-1.01.ebuild,v 1.1 2011/01/05 03:30:30 robbat2 Exp $

EAPI=3
DESCRIPTION="A simple entropy daemon using the HAVEGE algorithm"
HOMEPAGE="http://www.issihosts.com/haveged/"
SRC_URI="http://www.issihosts.com/haveged/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

src_configure() {
	econf --bindir=/usr/sbin || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	# This is a RedHat init script
	rm -rf "${D}"/etc/init.d/haveged
	# Install gentoo ones instead
	newinitd "${FILESDIR}"/haveged-init.d haveged
	newconfd "${FILESDIR}"/haveged-conf.d haveged
}
