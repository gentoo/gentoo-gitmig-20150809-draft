# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.2.0_p1.ebuild,v 1.2 2005/06/10 20:13:41 robbat2 Exp $

inherit flag-o-matic

MY_P="${P/_}"
DESCRIPTION="A freely downloadable cluster resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.supercluster.org/torque/"
SRC_URI="http://supercluster.org/downloads/torque/${MY_P}.tar.gz"
LICENSE="openpbs"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc tcltk X"

# ed is used by makedepend-sh
DEPEND="virtual/libc
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tcl )
		sys-apps/ed"
RDEPEND="net-misc/openssh"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	append-ldflags -Wl,-z,now

	unpack ${A}
	epatch ${FILESDIR}/${PV}-respect-ldflags.patch || die "Failed to fix ldflags"

	# this thing doesn't use make install, but rather it's own install script
	# fix it here so the install dirs are set to the ${D} directory
	cd ${S}/buildutils && \
	mv pbs_mkdirs.in pbs_mkdirs.in-orig && \
	sed -e "s|prefix=@prefix@|prefix=\${D}@prefix@| ; \
		s|PBS_SERVER_HOME=@PBS_SERVER_HOME@|PBS_SERVER_HOME=\${D}@PBS_SERVER_HOME@| ; \
		s|PBS_DEFAULT_FILE=@PBS_DEFAULT_FILE@|PBS_DEFAULT_FILE=\${D}@PBS_DEFAULT_FILE@| ; \
		s|PBS_ENVIRON=@PBS_ENVIRON@|PBS_ENVIRON=\${D}@PBS_ENVIRON@|" \
			pbs_mkdirs.in-orig > pbs_mkdirs.in || \
	die 'Failed to set build to use $D'

	# Tries to use absolute /tmp/ for tempfiles which fails miserably.
	sed -i -e "s|/tmp/|\${TMPDIR}/|g" makedepend-sh || die "Failed TMPDIR change"
}

src_compile() {
#	local myconf
#	use X || myconf="--disable-gui"
#	use tcltk && myconf="${myconf} --with-tcl"
#	use doc && myconf="${myconf} --enable-docs"

#	./configure ${myconf} \
	./configure \
		$(use_enable X gui) \
		$(use_with tcltk tcl) \
		$(use_enable doc docs) \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-server \
		--enable-mom \
		--enable-clients \
		--set-server-home=/usr/spool/PBS \
		--set-environ=/etc/pbs_environment || die "./configure failed"

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		PBS_SERVER_HOME=${D}/usr/spool/PBS \
		install || die

	dodoc INSTALL PBS_License.txt README.torque Release_Notes
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbs.rc pbs
}
