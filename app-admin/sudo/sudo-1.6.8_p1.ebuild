# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.8_p1.ebuild,v 1.1 2004/09/17 16:00:30 aliz Exp $

inherit gnuconfig eutils

#
# TODO: Fix support for krb4 and krb5
#

DESCRIPTION="Allows certain users/groups to run commands as root"
HOMEPAGE="http://www.sudo.ws/"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P/_/}.tar.gz"

LICENSE="Sudo"
SLOT="0"
KEYWORDS="-*"
#KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="pam"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A} ; cd ${S}
	gnuconfig_update

	epatch ${FILESDIR}/${P}-suid_fix.patch
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
