# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/selinux-base-policy/selinux-base-policy-20030604.ebuild,v 1.3 2003/06/21 21:19:40 drobbins Exp $

IUSE="selinux"

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
RDEPEND="|| (
		>=sys-kernel/selinux-sources-2.4.20-r1
		>=sys-kernel/hardened-sources-2.4.20-r1
	    )
	 sys-devel/m4
	 sys-devel/make"
DEPEND=""
S=${WORKDIR}/base-policy

pkg_setup() {
	if [ -z "`use selinux`" ]; then
		eerror "selinux is missing from your USE.  You seem to be using the"
		eerror "incorrect profile.  SELinux has a different profile than"
		eerror "mainline Gentoo.  Make sure the /etc/make.profile symbolic"
		eend 1 "link is pointing to /usr/portage/profiles/selinux-x86-1.4/"
	fi
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
