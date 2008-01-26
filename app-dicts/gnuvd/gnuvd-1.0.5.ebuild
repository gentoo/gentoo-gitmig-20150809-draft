# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gnuvd/gnuvd-1.0.5.ebuild,v 1.1 2008/01/26 18:30:17 philantrop Exp $

DESCRIPTION="gnuvd is a command line interface to the Van Dale(tm) on-line Dutch dictionary."
HOMEPAGE="http://www.djcbsoftware.nl/code/gnuvd"
SRC_URI="${HOMEPAGE}/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.nl || die "installing docs failed"
}
