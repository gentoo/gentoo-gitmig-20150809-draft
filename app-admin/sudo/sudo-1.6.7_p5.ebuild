# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.7_p5.ebuild,v 1.1 2003/05/19 19:02:26 aliz Exp $

DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P/_/}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"

SLOT="0"
LICENSE="Sudo"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa"
IUSE="pam"

S=${WORKDIR}/${P/_/}
DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

#
# TODO: Fix support for krb4 and krb5
#

src_compile() {
	local myconf
	use pam \
		&& myconf="--with-pam" \
		|| myconf="--without-pam"

	econf --with-all-insults \
		--disable-path-info \
		--with-env-editor \
		${myconf}
	emake || die
}

src_install() {
	einstall
	dodoc BUGS CHANGES HISTORY LICENSE PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}
