# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-20040408.ebuild,v 1.1 2004/04/08 19:16:54 pebenito Exp $

IUSE="build"

inherit eutils

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
DEPEND="build? ( sys-devel/make
		 sys-devel/m4 )"
RDEPEND="sys-devel/m4
	 sys-devel/make
	 !build? ( >=sys-libs/pam-0.77 )"

S=${WORKDIR}/base-policy

[ -z ${POLICYDIR} ] && POLICYDIR="/etc/security/selinux/src/policy"

# deprecated policies:
DEPRECATED="domains/program/devfsd.te domains/program/opt.te
	file_contexts/program/devfsd.fc file_contexts/program/opt.fc
	file_contexts/users.fc"

src_install() {
	if use build; then
		# generate a file_contexts
		dodir ${POLICYDIR}/file_contexts
		einfo "Ignore the checkpolicy error on the next line."
		make -C ${S} \
			FC=${D}/${POLICYDIR}/file_contexts/file_contexts \
			${D}/${POLICYDIR}/file_contexts/file_contexts

		[ ! -f ${D}/${POLICYDIR}/file_contexts/file_contexts ] && \
			die "file_contexts was not generated."
	else
		# install full policy
		dodir /etc/security/selinux/src

		insinto /etc/security
		doins ${S}/appconfig/*

		cp -a ${S} ${D}/${POLICYDIR}
		rm -fR ${D}/${POLICYDIR}/appconfig
	fi
}

pkg_postinst() {
	local isdeprecated
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
	echo

	einfo "Checking for deprecated policy..."
	for i in $DEPRECATED; do
		if [ -f "${POLICYDIR}/${i}" ]; then
			eerror "${POLICYDIR}/${i}"
			isdeprecated="y"
		fi
	done
	[ "${isdeprecated}" ] && \
		eerror "The above policy file(s) should be removed if possible." || \
		einfo "None found."

	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	sleep 4
}
