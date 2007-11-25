# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-2.2.1.ebuild,v 1.2 2007/11/25 00:28:37 mr_bones_ Exp $

inherit autotools flag-o-matic eutils

DESCRIPTION="Resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.clusterresources.com/products/torque/"
SRC_URI="http://www.clusterresources.com/downloads/${PN}/${P}.tar.gz"

LICENSE="openpbs"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="tk crypt server syslog doc"
PROVIDE="virtual/pbs"

# ed is used by makedepend-sh
DEPEND_COMMON="virtual/libc
	sys-libs/ncurses
	sys-libs/readline
	tk? ( dev-lang/tk )
	syslog? ( virtual/logger )
	!virtual/pbs
	!sys-cluster/openpbs-common"

DEPEND="${DEPEND_COMMON}
	sys-apps/ed"

RDEPEND="${DEPEND_COMMON}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )"

# TODO:  Conforming to FHS?  There are config files here
# and files that are processed by the daemons.
SPOOL_LOCATION="/var/spool"
PBS_SERVER_HOME="${SPOOL_LOCATION}/torque/"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-setuid-safety-am.patch
	# Otherwise we'll fail due to strings over ISO C89 defined length 509
	sed -i 's:gcc_warning_flags="\(.*\)-Werror":gcc_warning_flags="\1":' configure.ac
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	local myconf

	if use crypt; then
		myconf="--with-rcp=scp"
	else
		myconf="--with-rcp=mom_rcp"
	fi
	# TODO:  Allow cpusets
	econf \
		$(use_enable tk gui) \
		$(use_enable syslog) \
		$(use_enable server) \
		--with-server-home=${PBS_SERVER_HOME} \
		--with-environ=/etc/pbs_environment \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

# WARNING
# OpenPBS is extremely stubborn about directory permissions. Sometimes it will
# just fall over with the error message, but in some spots it will just ignore
# you and fail strangely. Likewise it also barfs on our .keep files!
pbs_createspool() {
	local root="$1"
	local s="${SPOOL_LOCATION}"
	local h="${PBS_SERVER_HOME}"
	local sp="${h}/server_priv"
	einfo "Building spool directory under ${D}${h}"
	local a d m
	local dir_spec="
			0755:${h}/aux 0700:${h}/checkpoint
			0755:${h}/mom_logs 0751:${h}/mom_priv 0751:${h}/mom_priv/jobs
			1777:${h}/spool 1777:${h}/undelivered"

	if use server; then
		dir_spec="${dir_spec} 0755:${h}/sched_logs
			0755:${h}/sched_priv/accounting 0755:${h}/server_logs
			0750:${h}/server_priv 0755:${h}/server_priv/accounting
			0750:${h}/server_priv/acl_groups 0750:${h}/server_priv/acl_hosts
			0750:${h}/server_priv/acl_svr 0750:${h}/server_priv/acl_users
			0750:${h}/server_priv/jobs 0750:${h}/server_priv/queues"
	fi

	for a in ${dir_spec}; do
		d="${a/*:}"
		m="${a/:*}"
		if [[ ! -d "${root}${d}" ]]; then
			install -d -m${m} "${root}${d}"
		else
			chmod ${m} "${root}${d}"
		fi
		# (#149226) If we're running in src_*, then keepdir
		if [[ "${root}" = "${D}" ]]; then
			keepdir ${d}
		fi
	done
}

src_install() {
	# Make directories first
	pbs_createspool "${D}"

	make DESTDIR="${D}" install || die "make install failed"

	dodoc CHANGELOG DEVELOPMENT README.* Release_Notes || die "dodoc failed"
	if use doc; then
		dodoc doc/admin_guide.ps doc/*.pdf || die "dodoc failed"
	fi

	# this file MUST exist for PBS/Torque to work
	# but try to preserve any customatizations that the user has made
	dodir /etc
	mv "${D}"${PBS_SERVER_HOME}/pbs_environment "${D}"/etc/

	# The build script isn't alternative install location friendly,
	# So we have to fix some hard-coded paths in tclIndex for xpbs* to work
	for file in `find "${D}" -iname tclIndex`; do
		sed -e "s/${D//\// }/ /" "${file}" > "${file}.new"
		mv "${file}.new" "${file}"
	done

	if use server; then
		newinitd "${FILESDIR}"/pbs_server-init.d-2.2.1 pbs_server
		newinitd "${FILESDIR}"/pbs_sched-init.d-2.2.1 pbs_sched
	fi
	newinitd "${FILESDIR}"/pbs_mom-init.d-2.2.1 pbs_mom
	newconfd "${FILESDIR}"/torque-conf.d-2.2.1 torque
	newenvd "${FILESDIR}"/torque-env.d-2.2.1 25torque
}

pkg_preinst() {
	if [[ -f "${ROOT}etc/pbs_environment" ]]; then
		cp "${ROOT}etc/pbs_environment" "${D}"/etc/pbs_environment
	fi
	if [[ -f "${ROOT}${PBS_SERVER_HOME}server_name" ]]; then
		cp "${ROOT}${PBS_SERVER_HOME}server_name" "${D}${PBS_SERVER_HOME}server_name"
	fi
}

pkg_postinst() {
	pbs_createspool "${ROOT}"
	elog "If this is the first time torque has been installed, then you are not
	ready to start the server.  Please refer to the documentation located at:
	http://www.clusterresources.com/wiki/doku.php?id=torque:torque_wiki"

	elog "There are a couple of changes in this ebuild.
	1.) The pbs-server-home has been moved from /var/spool/PBS to
	    /var/spool/torque.
	2.) pbs_server, pbs_mom and pbs_sched now have separate init scripts"
}
