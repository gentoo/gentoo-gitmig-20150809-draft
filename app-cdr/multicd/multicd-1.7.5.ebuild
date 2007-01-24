# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/multicd/multicd-1.7.5.ebuild,v 1.3 2007/01/24 02:26:26 genone Exp $

DESCRIPTION="Tool for making direct copies of your files to multiple cd's"
HOMEPAGE="http://danborn.net/multicd/"
SRC_URI="http://danborn.net/multicd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.6
	virtual/cdrtools"

src_install() {
	exeinto "/opt/${PN}"
	doexe multicd || die "doexe failed"
	dodoc sample_multicdrc
}

pkg_postinst() {
	elog
	elog "Copy and edit sample configuration file from"
	elog "/usr/share/doc/${PF}"
	elog "directory to /etc directory as multicdrc"
	elog
}
