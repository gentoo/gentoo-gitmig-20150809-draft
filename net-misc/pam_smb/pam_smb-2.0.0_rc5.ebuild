# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pam_smb/pam_smb-2.0.0_rc5.ebuild,v 1.3 2004/07/15 03:17:28 agriffis Exp $

DESCRIPTION="The PAM SMB module, which allows authentication against an NT server."
HOMEPAGE="http://www.csn.ul.ie/~airlied/pam_smb/"

MY_P=${P/_rc/-rc}

S=${WORKDIR}/${MY_P}
SRC_URI="mirror://samba/pam_smb/v2/${MY_P}.tar.gz
	http://www.csn.ul.ie/~airlied/pam_smb/v2/pam_smb-2.0.0-rc5.tar.gz"

DEPEND=">=sys-libs/pam-0.75"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	econf --disable-root-only || die
	emake || die
}

src_install() {
	exeinto /lib/security
	doexe pamsmbm/pam_smb_auth.so
	exeinto /usr/sbin
	doexe pamsmbd/pamsmbd

	dodoc BUGS CHANGES COPYING README TODO INSTALL \
		faq/{pam_smb_faq.sgml,additions.txt}
	docinto pam.d
	dodoc pam_smb.conf*

	exeinto /etc/init.d
	newexe ${FILESDIR}/pamsmbd-init pamsmbd
}

pkg_postinst() {
	einfo
	einfo "You must create /etc/pam_smb.conf yourself, containing"
	einfo "your domainname, PDC and BDC.  See example files in docdir."
	einfo
}
