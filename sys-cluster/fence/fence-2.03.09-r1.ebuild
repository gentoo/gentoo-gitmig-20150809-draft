# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fence/fence-2.03.09-r1.ebuild,v 1.2 2008/12/06 17:49:55 xmerlin Exp $

inherit eutils versionator

CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="I/O group fencing system"
HOMEPAGE="http://sources.redhat.com/cluster/wiki/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=sys-cluster/ccs-${CLUSTER_RELEASE}*
	=sys-cluster/openais-0.80.3*
	=sys-cluster/dlm-lib-${CLUSTER_RELEASE}*
	=sys-cluster/cman-lib-${CLUSTER_RELEASE}*
	dev-perl/Net-Telnet
	dev-perl/Net-SSLeay
	dev-python/pexpect
	"

RDEPEND="$DEPEND"

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod u+x "${WORKDIR}"/${MY_P}/scripts/define2var

	epatch "${FILESDIR}"/fence-2.03.09-ipmi_fix_help_typo_RH_BZ_210687.patch || die
	epatch "${FILESDIR}"/fence-2.03.09-ipmi_fix_shell.patch || die
	epatch "${FILESDIR}"/fence-2.03.09-ipmi_fix_parameters_RH_BZ_447964.patch || die
	epatch "${FILESDIR}"/fence-2.03.09-ipmi_lan_timeout_adjusted_and_configurable.patch || die
}

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--dlmlibdir=/usr/lib \
			--dlmincdir=/usr/include \
			--cmanlibdir=/usr/lib \
			--cmanincdir=/usr/include \
	) || die "configure problem"

	(cd "${WORKDIR}"/${MY_P}/group;
		emake -j1 clean all \
	) || die "compile problem"

	# fix the manual pages have executable bit
	sed -i -e '
		/\tinstall -d/s/install/& -m 0755/; t
		/\tinstall/s/install/& -m 0644/' \
		man/Makefile

	emake -j1 clean all || die "compile problem"
}

src_install() {
	(cd "${WORKDIR}"/${MY_P}/group;
		emake DESTDIR="${D}" install \
	) || die "install problem"

	emake DESTDIR="${D}" install || die "install problem"
}
