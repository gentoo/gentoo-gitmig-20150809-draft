# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.7_p5.ebuild,v 1.17 2004/07/31 04:56:31 solar Exp $

inherit gnuconfig

#
# TODO: Fix support for krb4 and krb5
#

DESCRIPTION="Allows certain users/groups to run commands as root"
HOMEPAGE="http://www.sudo.ws/"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P/_/}.tar.gz"

LICENSE="Sudo"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE="pam"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	gnuconfig_update ${S}
}

src_compile() {
	econf \
		--with-all-insults \
		--disable-path-info \
		--with-env-editor \
		`use_with pam` \
		|| die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc BUGS CHANGES HISTORY PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}
