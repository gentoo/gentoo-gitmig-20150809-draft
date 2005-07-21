# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.2.0_p1-r3.ebuild,v 1.1 2005/07/21 01:08:16 robbat2 Exp $

inherit flag-o-matic eutils

MY_P="${P/_}"
DESCRIPTION="A freely downloadable cluster resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.supercluster.org/torque/"
SRC_URI="http://supercluster.org/downloads/torque/${MY_P}.tar.gz
		 mirror://gentoo/${P}-respect-destdir.patch.gz
		 mirror://gentoo/${P}-respect-ldflags.patch.gz"
LICENSE="openpbs"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc tcltk X"
PROVIDE="virtual/pbs"

# ed is used by makedepend-sh
DEPEND_COMMON="virtual/libc
			   X? ( virtual/x11 )
			   tcltk? ( dev-lang/tcl )
			   !virtual/pbs"
DEPEND="${DEPEND_COMMON}
		sys-apps/ed"
RDEPEND="${DEPEND_COMMON}
		 net-misc/openssh"
PDEPEND="sys-cluster/openpbs-common"

S="${WORKDIR}/${MY_P}"

SPOOL_LOCATION="/usr/spool" # this needs to move to /var later on
PBS_SERVER_HOME="${SPOOL_LOCATION}/PBS/"

src_unpack() {
	append-ldflags -Wl,-z,now

	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${P}-respect-ldflags.patch.gz || die "Failed to fix ldflags"
	EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${P}-respect-destdir.patch.gz || die "Failed to fix Makefiles for DESTDIR"

	# Tries to use absolute /tmp/ for tempfiles which fails miserably.
	sed -i -e "s|/tmp/|\${TMPDIR}/|g" ${S}/buildutils/makedepend-sh || die "Failed TMPDIR change"
}

src_compile() {
#	local myconf
#	use X || myconf="--disable-gui"
#	use tcltk && myconf="${myconf} --with-tcl"
#	use doc && myconf="${myconf} --enable-docs"

	./configure \
		$(use_enable X gui) \
		$(use_with tcltk tcl) \
		$(use_enable doc docs) \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--libdir="\${exec_prefix}/$(get_libdir)/pbs" \
		--enable-server \
		--enable-mom \
		--enable-clients \
		--set-server-home=${PBS_SERVER_HOME} \
		--set-environ=/etc/pbs_environment || die "./configure failed"

	emake || die "emake failed"
}

# WARNING
# OpenPBS is extremely stubborn about directory permissions. Sometimes it will
# just fall over with the error message, but in some spots it will just ignore
# you and fail strangely. Likewise it also barfs on our .keep files!
pbs_createspool() {
	root="$1"
	s="${root}${SPOOL_LOCATION}"
	h="${root}${PBS_SERVER_HOME}"
	install -d -m0755 "${h}"
	install -d -m1777 "${h}/spool" "${h}/undelivered"
	install -d -m0700 "${h}/checkpoint"
	install -d -m0755 "${h}/aux" "${h}/mom_logs" "${h}/sched_logs" "${h}/server_logs"
	install -d -m0750 "${h}/sched_priv" "${h}/server_priv"
	install -d -m0751 "${h}/mom_priv" "${h}/mom_priv/jobs"
	sp="${h}/server_priv"
	install -d -m0755 "${sp}/accounting"
	install -d -m0750 "${sp}/acl_groups" "${sp}/acl_hosts" "${sp}/acl_svr" "${sp}/acl_users" "${sp}/jobs" "${sp}/queues"
	# this file MUST exist for PBS/Torque to work
	install -d -m0755 "${root}/etc"
	touch ${root}/etc/pbs_environment
	chmod 644 ${root}/etc/pbs_environment
}

src_install() {
	# Make directories first
	pbs_createspool "${D}"

	make DESTDIR=${D} install || die

	dodoc INSTALL PBS_License.txt README.torque Release_Notes
	# Init scripts come from openpbs-common
	#newinitd ${FILESDIR}/pbs-init.d pbs
	#newconfd ${FILESDIR}/pbs-conf.d pbs
	dosym /usr/$(get_libdir)/pbs/libpbs.a /usr/$(get_libdir)/libpbs.a
}

pkg_postinst() {
	# make sure the damn directories exist
	pbs_createspool "${ROOT}"
}
