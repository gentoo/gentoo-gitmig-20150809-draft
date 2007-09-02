# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gnuvd/gnuvd-1.0.3.ebuild,v 1.1 2007/09/02 19:36:52 philantrop Exp $

DESCRIPTION="gnuvd is an online dictionary that uses the online dictionary of Van Dale"
HOMEPAGE="http://www.djcbsoftware.nl/code/gnuvd"
SRC_URI="${HOMEPAGE}/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

src_install() {
	emake DESTDIR=${D} install || die "installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.nl || die "installing docs failed"
}
