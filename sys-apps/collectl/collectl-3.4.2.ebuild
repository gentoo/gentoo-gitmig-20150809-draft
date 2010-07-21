# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/collectl/collectl-3.4.2.ebuild,v 1.1 2010/07/21 13:29:30 vapier Exp $

EAPI="2"

inherit eutils

DESCRIPTION="light-weight performance monitoring tool capable of reporting interactively as well as logging to disk"
HOMEPAGE="http://collectl.sourceforge.net/"
SRC_URI="mirror://sourceforge/collectl/${P}.src.tar.gz"

LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8
	virtual/perl-Time-HiRes
	>=dev-perl/Archive-Zip-1.20
	sys-apps/ethtool
	sys-apps/pciutils"

src_prepare() {
	sed -i \
		-e "/^DOCDIR/s:doc/collectl:doc/${PF}:" \
		INSTALL || die
}

src_install() {
	DESTDIR=${D} bash -ex ./INSTALL || die

	rm "${D}"/etc/init.d/* || die
	newinitd "${FILESDIR}"/collectl.initd collectl

	cd "${D}"/usr/share/doc/${PF}
	dohtml * || die
	rm -f ARTISTIC GPL COPYING *.html *.jpg *.css || die
	prepalldocs
}
