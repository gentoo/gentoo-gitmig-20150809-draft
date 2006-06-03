# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_p11/pam_p11-0.1.2.ebuild,v 1.1 2006/06/03 14:56:35 kaiowas Exp $

inherit pam

DESCRIPTION="pam_p11 is a pam package for using cryptographic tokens as authentication"
HOMEPAGE="http://www.opensc-project.org/pam_p11/"
SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/pam
		dev-libs/libp11"
RDEPEND="${DEPEND}"

src_install() {
	dopammod ${S}/src/.libs/pam_p11_opensc.so
	dopammod ${S}/src/.libs/pam_p11_openssh.so

	dohtml doc/*.html doc/*.css
}

