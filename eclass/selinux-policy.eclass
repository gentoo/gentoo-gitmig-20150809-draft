# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/selinux-policy.eclass,v 1.7 2004/01/26 08:42:06 carpaski Exp $

# Eclass for installing SELinux policy, and optionally
# reloading the policy

ECLASS="selinux-policy"
INHERITED="$INHERITED $ECLASS"

HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${PN/selinux-}"

IUSE=""

newrdepend ">=sec-policy/selinux-base-policy-20030729"

[ -z "${POLICYDIR}" ] && POLICYDIR="/etc/security/selinux/src/policy"

SAVENAME="`date +%Y%m%d%H%M`-${PN}.tar.bz2"
SAVEDIR="`echo "${POLICYDIR}" | cut -d/ -f6`"

selinux-policy_src_compile() {
	cd ${S}

	einfo "Backup of policy source is \"${SAVENAME}\"."
	debug-print "POLICYDIR is \"${POLICYDIR}\""
	debug-print "SAVEDIR is \"${SAVEDIR}\""

	# create a backup of the current policy
	tar -C /etc/security/selinux/src  --exclude policy.12 --exclude tmp \
		--exclude policy.conf -jcf ${SAVENAME} ${SAVEDIR}/
}

selinux-policy_src_install() {
	cd ${S}

	insinto /etc/security/selinux/src/policy-backup
	doins ${SAVENAME}

	if [ -n "${TEFILES}" ]; then
		debug-print "TEFILES is \"${TEFILES}\""
		insinto ${POLICYDIR}/domains/program
		doins ${TEFILES} || die
	fi

	if [ -n "${FCFILES}" ]; then
		debug-print "FCFILES is \"${FCFILES}\""
		insinto ${POLICYDIR}/file_contexts/program
		doins ${FCFILES} || die
	fi

	if [ -n "${MACROS}" ]; then
		debug-print "MACROS is \"${MACROS}\""
		insinto ${POLICYDIR}/macros/program
		doins ${MACROS} || die
	fi
}

selinux-policy_pkg_postinst() {
	if [ "`has "loadpolicy" $FEATURES`" ]; then
		ebegin "Automatically loading policy"
		make -C ${POLICYDIR} load
		eend $?

		ebegin "Regenerating file contexts"
		[ -f ${POLICYDIR}/file_contexts/file_contexts ] && \
			rm -f ${POLICYDIR}/file_contexts/file_contexts
		make -C ${POLICYDIR} file_contexts/file_contexts &> /dev/null

		# do a test relabel to make sure file
		# contexts work (doesnt change any labels)
		echo "/etc/passwd" | /usr/sbin/setfiles \
			${POLICYDIR}/file_contexts/file_contexts -sqn
		eend $?
	else
		echo
		echo
		eerror "Policy has not been loaded.  It is strongly suggested"
		eerror "that the policy be loaded before continuing!!"
		echo
		einfo "Automatic policy loading can be enabled by adding"
		einfo "\"loadpolicy\" to the FEATURES in make.conf."
		echo
		echo
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
		sleep 4
	fi
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst
