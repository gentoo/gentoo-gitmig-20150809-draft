# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/biabam/biabam-0.9.7.ebuild,v 1.1 2005/02/10 13:13:46 ferdy Exp $

DESCRIPTION="Biabam is a small commandline tool for sending mail attachments"
HOMEPAGE="http://www.mmj.dk/biabam/"
SRC_URI="http://www.mmj.dk/biabam/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-arch/sharutils
	app-shells/bash
	sys-apps/file
	virtual/mta"

src_install() {
	dodoc COPYING README
	dobin biabam
}
