# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.0.1_p6.ebuild,v 1.1 2005/03/15 21:59:03 seemant Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A freely downloadable cluster resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.supercluster.org/torque/"
SRC_URI="http://supercluster.org/downloads/torque/${MY_P}.tar.gz"
LICENSE="openpbs"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="X tcltk"

DEPEND="virtual/libc
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tcl )"
RDEPEND="net-misc/openssh"

src_unpack() {
	unpack ${A}; cd ${S}
	# this thing doesn't use make install, but rather it's own install script
	# fix it here so the install dirs are set to the ${D} directory
	cd buildutils
	sed -i -e "s|prefix=@prefix@|prefix=\${D}@prefix@|" \
		-e "s|\(PBS_SERVER_HOME=\)\(@PBS_SERVER_HOME@\)|\1\${D}\2|" \
		-e "s|\(PBS_DEFAULT_FILE=\)\(@PBS_DEFAULT_FILE@\)|\1\${D}\2|" \
		-e "s|\(PBS_ENVIRON=\)\(@PBS_ENVIRON@\)|\1\${D}\2|" \
			pbs_mkdirs.in

	# Is this one needed??
	#	-e "s|\(PBS_DEFAULT_SERVER=\)\(@PBS_DEFAULT_SERVER@\)|\1\${D}\2|" \
}

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-docs \
		--enable-server \
		--enable-mom \
		--enable-clients \
		--set-server-home=/usr/spool/PBS \
		--set-environ=/etc/pbs_environment \
		`use_enable X gui` \
		`use_with tcltk tcl` || die "./configure failed"

	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		PBS_SERVER_HOME=${D}/usr/spool/PBS \
		install || die

	dodoc INSTALL PBS_License.text Read.Me Release_Notes
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbs.rc pbs
}
