# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conary-policy/conary-policy-1.0.9.ebuild,v 1.1 2006/10/23 14:12:33 smithj Exp $

DESCRIPTION="distribution policy for the conary package manager"
HOMEPAGE="http://wiki.rpath.com/wiki/Conary"
SRC_URI="ftp://download.rpath.com/conary/${P}.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/python-2.4*
		app-admin/conary"

src_compile() {
	emake || die "Make failure"
}

src_install() {
	make DESTDIR=${D} install
}
