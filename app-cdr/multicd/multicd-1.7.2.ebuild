# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/multicd/multicd-1.7.2.ebuild,v 1.4 2004/03/19 09:40:54 mr_bones_ Exp $

DESCRIPTION="Tool for making direct copies of your files to multiple cd's"
HOMEPAGE="http://danborn.net/multicd/"
SRC_URI="http://danborn.net/multicd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=app-cdr/cdrtools-1.11.33"

src_install() {
	exeinto "/opt/${PN}"
	doexe multicd || die "doexe failed"
	dodoc sample_multicdrc
}

pkg_postinst() {
	einfo
	einfo "Copy and edit sample configuration file from"
	einfo "/usr/share/doc/${PF}"
	einfo "directory to /etc directory as multicdrc"
	einfo
}
