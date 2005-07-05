# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.2.0_p1-r2.ebuild,v 1.1 2005/07/05 20:03:08 robbat2 Exp $

inherit flag-o-matic eutils

MY_P="${P/_}"
DESCRIPTION="A freely downloadable cluster resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.supercluster.org/torque/"
SRC_URI="http://supercluster.org/downloads/torque/${MY_P}.tar.gz"
LICENSE="openpbs"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
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

src_unpack() {
	append-ldflags -Wl,-z,now

	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PV}-respect-ldflags.patch || die "Failed to fix ldflags"
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PV}-respect-destdir.patch || die "Failed to fix Makefiles for DESTDIR"

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
		--libdir="\${exec_prefix}/$(get_libdir)/torque" \
		--enable-server \
		--enable-mom \
		--enable-clients \
		--set-server-home=/usr/spool/PBS \
		--set-environ=/etc/pbs_environment || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc INSTALL PBS_License.txt README.torque Release_Notes
	# Init scripts come from openpbs-common
	#newinitd ${FILESDIR}/pbs-init.d pbs
	#newconfd ${FILESDIR}/pbs-conf.d pbs
	dosym /usr/$(get_libdir)/torque/libpbs.a /usr/$(get_libdir)/libpbs.a
}
