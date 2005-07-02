# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_require/pam_require-0.6.ebuild,v 1.2 2005/07/02 16:05:47 flameeyes Exp $

inherit eutils pam

DESCRIPTION="Allows you to require a special group or user to access a service."
HOMEPAGE="http://www.splitbrain.org/Programming/C/pam_require/"
SRC_URI="http://www.splitbrain.org/Programming/C/pam_require/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-libs/pam-0.72"

src_compile() {
	./configure --prefix=/ || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dopammod ${S}/pam_require.so

	dodoc AUTHORS ChangeLog NEWS README
}
