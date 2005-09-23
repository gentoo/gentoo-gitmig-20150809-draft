# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mxml2man/mxml2man-8.5.9.1.ebuild,v 1.1 2005/09/23 22:43:58 flameeyes Exp $

DESCRIPTION="Apple's xml2man in an Autotool fashion"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/projects.xhtml#mxml2man"
SRC_URI="http://digilander.libero.it/dgp85/files/${P}.tar.bz2"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libxml2"

src_install() {
	make DESTDIR="${D}" install
	dodoc Syntax README

	# This is already provided by system on macos/Darwin, being this a modified
	# version of Apple's xml2man
	[[ ${USERLAND} == "Darwin" ]] && rm -f ${D}/usr/bin/hdxml2manxml
}
