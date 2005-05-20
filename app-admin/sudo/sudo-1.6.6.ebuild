# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.6.ebuild,v 1.21 2005/05/20 12:37:53 flameeyes Exp $

inherit pam

DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/OLD/${P}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"

LICENSE="Sudo"
SLOT="0"
KEYWORDS="alpha hppa ppc sparc x86"
IUSE="pam"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
	econf \
		--with-all-insults \
		--disable-path-info \
		--with-env-editor \
		$(use_with pam) \
		|| die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc BUGS CHANGES HISTORY PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*
	dopamd ${FILESDIR}/sudo
}
