# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.6.ebuild,v 1.7 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"

SLOT="0"
LICENSE="Sudo"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
	local myconf
	use pam \
		&& myconf="--with-pam" \
		|| myconf="--without-pam"

	econf \
		--with-all-insults \
		--disable-path-info \
		--with-env-editor \
		${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc BUGS CHANGES HISTORY LICENSE PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}
