# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/selinux-base-policy/selinux-base-policy-20030522.ebuild,v 1.1 2003/05/22 15:38:59 pebenito Exp $

IUSE="selinux"

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND="|| (
		>=sys-kernel/selinux-sources-2.4.20-r1
		>=sys-kernel/hardened-sources-2.4.20-r1
	    )"
DEPEND=""
S=${WORKDIR}/base-policy

pkg_setup() {
        use selinux || eend 1 "You must have selinux in your USE"
}

src_install() {
	dodir /etc/security/selinux/src

	insinto /etc/security
	doins ${S}/appconfig/*
	rm -fR ${S}/appconfig

	mv ${S} ${D}/etc/security/selinux/src/policy
}

pkg_postinst() {
	echo
	einfo "This is the base policy for SELinux on Gentoo.  This policy"
	einfo "package only covers the applications in the system profile."
	einfo "More policy may need to be added according to your requirements."
	echo
	eerror "It is STRONGLY suggested that you evaluate and merge the"
	eerror "policy changes.  If any of the file contexts (*.fc) have"
	eerror "changed, you should also relabel."
	echo
	ewarn "Please check the Changelog, there may be important information."
	echo
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	sleep 8
}
