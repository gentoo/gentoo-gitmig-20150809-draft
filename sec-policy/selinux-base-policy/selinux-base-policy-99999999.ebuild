# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-99999999.ebuild,v 1.3 2006/02/24 03:12:31 pebenito Exp $

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

	for i in ${POLICY_TYPES}; do
		mkdir -p ${S}/${i}/policy
		cp ${FILESDIR}/modules.conf.${i} ${S}/${i}/policy/modules.conf
	done
}

src_compile() {
	cd ${S}/refpolicy

	make ${OPTS} generate || die "Failed to create generated module files"

	make ${OPTS} xml || "XML generation failed."

	for i in ${POLICY_TYPES}; do
#		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} conf \
#			|| die "${i} modules.conf update failed"

		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} base \
			|| die "${i} compile failed"
	done
}

src_install() {
	OPTS="${OPTS} DESTDIR=${D}"

	cd ${S}/refpolicy

	for i in ${POLICY_TYPES}; do
		make ${OPTS} TYPE=${i} NAME=${i} LOCAL_ROOT=${S}/${i} install \
			|| die "${i} install failed."

		make ${OPTS} TYPE=${i} NAME=${i} install-headers \
			|| die "${i} headers install failed."

		echo "run_init_t" > ${D}/etc/selinux/${i}/contexts/run_init_type

		# libsemanage won't make this on its own
		keepdir /etc/selinux/${i}/policy
	done

	dodoc doc/Makefile.example doc/example.{te,fc,if}

	insinto /etc/selinux
	doins ${FILESDIR}/semanage.conf
	doins ${FILESDIR}/config
}

pkg_postinst() {
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
