# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-99999999.ebuild,v 1.2 2006/02/14 03:37:59 pebenito Exp $

POLICY_TYPES="strict targeted"
OPTS="MONOLITHIC=n DISTRO=gentoo QUIET=y"

IUSE=""

ECVS_SERVER="cvs.sf.net:/cvsroot/serefpolicy"
ECVS_MODULE="refpolicy"
ECVS_USER="anonymous"

inherit eutils cvs

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips ~alpha"
#KEYWORDS="x86 ppc sparc amd64 mips alpha"

RDEPEND=">=sys-apps/policycoreutils-1.28"
DEPEND="${RDEPEND}
	sys-devel/m4
	>=sys-apps/checkpolicy-1.28"

S=${WORKDIR}/

src_unpack() {
	cvs_src_unpack

	cd ${S}
	for i in ${POLICY_TYPES}; do
		einfo "Unpacking sources for ${i} policy"
		cp -a refpolicy ${i}
		cp ${FILESDIR}/modules.conf.${i} ${i}/policy/modules.conf
	done
}

src_compile() {
	for i in ${POLICY_TYPES}; do
		cd ${S}/${i}
#		make ${OPTS} TYPE=${i} NAME=${i} conf \
#			|| die "${i} modules.conf update failed"

		make ${OPTS} TYPE=${i} NAME=${i} base \
			|| die "${i} compile failed"
	done
}

src_install() {
	OPTS="${OPTS} DESTDIR=${D}"

	for i in ${POLICY_TYPES}; do
		cd ${S}/${i}
		make ${OPTS} TYPE=${i} NAME=${i} install \
			|| die "${i} install failed."

		make ${OPTS} TYPE=${i} NAME=${i} install-headers \
			|| die "${i} headers install failed."

		echo "run_init_t" > ${D}/etc/selinux/${i}/contexts/run_init_type
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins ${FILESDIR}/semanage.conf
	doins ${FILESDIR}/config
}

pkg_postinst() {
	# workaround bugs in libsemanage
	for i in ${POLICY_TYPES}; do
		# libsemanage won't make this on its own
		mkdir -p /etc/selinux/${i}/policy

		# currently seusers cannot be inferred.  for now
		# inject one into the module store
		if [ ! -f /etc/selinux/${i}/modules/active/seusers ]; then
			mkdir -p /etc/selinux/${i}/modules/active
			echo "root:root:" > /etc/selinux/${i}/modules/active/seusers
			echo "__default__:user_u:" >> /etc/selinux/${i}/modules/active/seusers
		fi
	done

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
