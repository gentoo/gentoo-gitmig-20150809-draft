# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/torque/torque-1.0.1-r6.ebuild,v 1.7 2004/08/08 00:41:24 slarti Exp $

S=${WORKDIR}/`echo ${A} | sed -e 's/\.tar\.gz//g'`

DESCRIPTION="A freely downloadable cluster resource manager and queuing system based on OpenPBS"
HOMEPAGE="http://www.supercluster.org/torque/"
SRC_URI="http://supercluster.org/downloads/torque/torque-1.0.1p6.tar.gz"
LICENSE="openpbs"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="X tcltk"

DEPEND="virtual/libc
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tcl )"
RDEPEND="net-misc/openssh"

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}
	# this thing doesn't use make install, but rather it's own install script
	# fix it here so the install dirs are set to the ${D} directory
	cd buildutils
	mv pbs_mkdirs.in pbs_mkdirs.in-orig
	sed -e "s|prefix=@prefix@|prefix=\${D}@prefix@| ; \
		s|PBS_SERVER_HOME=@PBS_SERVER_HOME@|PBS_SERVER_HOME=\${D}@PBS_SERVER_HOME@| ; \
		s|PBS_DEFAULT_FILE=@PBS_DEFAULT_FILE@|PBS_DEFAULT_FILE=\${D}@PBS_DEFAULT_FILE@| ; \
		s|PBS_ENVIRON=@PBS_ENVIRON@|PBS_ENVIRON=\${D}@PBS_ENVIRON@|" \
			pbs_mkdirs.in-orig > pbs_mkdirs.in
}

src_compile() {
	local myconf
	use X || myconf="--disable-gui"
	use tcltk && myconf="${myconf} --with-tcl"

	./configure ${myconf} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-docs \
		--enable-server \
		--enable-mom \
		--enable-clients \
		--set-server-home=/usr/spool/PBS \
		--set-environ=/etc/pbs_environment || die "./configure failed"

	make || die
}

src_install() {
	make prefix=${D}/usr \
		 mandir=${D}/usr/share/man \
		 PBS_SERVER_HOME=${D}/usr/spool/PBS \
	     install || die

	dodoc INSTALL PBS_License.text Read.Me Release_Notes
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbs.rc pbs
}
