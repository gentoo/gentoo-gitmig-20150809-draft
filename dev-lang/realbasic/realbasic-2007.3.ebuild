# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/realbasic/realbasic-2007.3.ebuild,v 1.1 2007/08/22 16:10:10 vapier Exp $

inherit eutils portability

DESCRIPTION="VB6 for Linux!"
HOMEPAGE="http://www.realsoftware.com/products/realbasic/"
SRC_URI="http://realsoftware.cachefly.net/REALbasic2007r3/REALbasicLinux.tgz"

LICENSE="REALbasic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND=""

S=${WORKDIR}/REALbasic2007Release3

src_install() {
	dodir /opt/bin
	treecopy . "${D}"/opt/REALbasic || die
	dosym /opt/REALbasic/REALbasic2007 /opt/bin/REALbasic
	newicon RBCube.xpm REALbasic.xpm || die
	make_desktop_entry REALbasic REALbasic REALbasic.xpm
}
