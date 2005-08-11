# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.2.0_p1-r3.ebuild,v 1.3 2005/08/11 18:09:57 robbat2 Exp $

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
PDEPEND=">=sys-cluster/openpbs-common-1.1.0"

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
	s="${SPOOL_LOCATION}"
	h="${PBS_SERVER_HOME}"
	sp="${h}/server_priv"

	for a in \
			0755:${h} 0755:${h}/aux 0700:${h}/checkpoint \
			0755:${h}/mom_logs 0751:${h}/mom_priv 0751:${h}/mom_priv/jobs \
			0755:${h}/sched_logs 0750:${h}/sched_priv \
			0755:${h}/server_logs \
			0750:${h}/server_priv 0755:${h}/server_priv/accounting \
			0750:${h}/server_priv/acl_groups 0750:${h}/server_priv/acl_hosts \
			0750:${h}/server_priv/acl_svr 0750:${h}/server_priv/acl_users \
			0750:${h}/server_priv/jobs 0750:${h}/server_priv/queues \
			1777:${h}/spool 1777:${h}/undelivered ;
	do
		d="${a/*:}"
		m="${a/:*}"
		if [ ! -d "${d}" ]; then
			install -d -m${m} ${root}${d}
		else
			chmod ${m} ${root}${d}
		fi
	done
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

	# this file MUST exist for PBS/Torque to work
	# but try to preserve any customatizations that the user has made
	dodir /etc
	if [ -f ${ROOT}/etc/pbs_environment ]; then
		cp ${ROOT}/etc/pbs_environment ${D}/etc/pbs_environment
	else
		touch ${D}/etc/pbs_environment
	fi

	if [ -f "${ROOT}/usr/spool/PBS/server_name" ]; then
		cp "${ROOT}/usr/spool/PBS/server_name" "${D}/usr/spool/PBS/server_name"
	fi
}

pkg_postinst() {
	# make sure the damn directories exist
	pbs_createspool "${ROOT}"
}
