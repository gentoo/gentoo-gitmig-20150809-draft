# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_require/pam_require-0.6.ebuild,v 1.1 2004/12/05 12:51:32 trapni Exp $

inherit eutils

DESCRIPTION="Allows you to require a special group or user to access a service."
HOMEPAGE="http://www.splitbrain.org/Programming/C/pam_require/"
SRC_URI="http://www.splitbrain.org/Programming/C/pam_require/pam_require-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT=""
DEPEND=">=sys-libs/pam-0.72"
#RDEPEND=""

src_compile() {
	./configure --prefix=/ || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
