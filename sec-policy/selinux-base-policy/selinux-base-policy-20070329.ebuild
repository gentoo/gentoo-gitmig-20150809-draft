# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-20070329.ebuild,v 1.2 2007/03/30 13:29:49 pebenito Exp $

IUSE=""

inherit eutils

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="http://oss.tresys.com/files/refpolicy/refpolicy-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

#KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips ~alpha"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

RDEPEND=">=sys-apps/policycoreutils-1.30.30"
DEPEND="${RDEPEND}
	sys-devel/m4
	>=sys-apps/checkpolicy-1.30.12"

S=${WORKDIR}/

src_unpack() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	unpack ${A}

	cd ${S}/refpolicy
	epatch ${FILESDIR}/${PN}-${PV}.diff

	for i in ${POLICY_TYPES}; do
		mkdir -p ${S}/${i}/policy
		cp ${FILESDIR}/modules.conf.${i} ${S}/${i}/policy/modules.conf
	done
}

src_compile() {
	local OPTS="MONOLITHIC=n DISTRO=gentoo QUIET=y"
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	cd ${S}/refpolicy

	make ${OPTS} generate || die "Failed to create generated module files"

	make ${OPTS} xml || die "XML generation failed."

	for i in ${POLICY_TYPES}; do
#		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} conf \
#			|| die "${i} modules.conf update failed"

		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} base \
			|| die "${i} compile failed"
	done
}

src_install() {
	local OPTS="MONOLITHIC=n DISTRO=gentoo QUIET=y DESTDIR=${D}"
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	cd ${S}/refpolicy

	for i in ${POLICY_TYPES}; do
		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} install \
			|| die "${i} install failed."

		make ${OPTS} TYPE=${i} NAME=${i} install-headers \
			|| die "${i} headers install failed."

		echo "run_init_t" > ${D}/etc/selinux/${i}/contexts/run_init_type

		echo "textrel_shlib_t" >> ${D}/etc/selinux/${i}/contexts/customizable_types

		# libsemanage won't make this on its own
		keepdir /etc/selinux/${i}/policy
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins ${FILESDIR}/config
}

pkg_postinst() {
	[ -z "${POLICY_TYPES}" ] && local POLICY_TYPES="strict targeted"

	if has "loadpolicy" $FEATURES ; then
		for i in ${POLICY_TYPES}; do
			einfo "Inserting base module into ${i} module store."

			cd /usr/share/selinux/${i}
			semodule -s ${i} -b base.pp
		done
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
		ebeep 4
		epause 4
	fi
}
