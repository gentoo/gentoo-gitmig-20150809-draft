# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openpbs/openpbs-2.3.16-r1.ebuild,v 1.12 2004/11/24 08:19:05 mr_bones_ Exp $

inherit eutils

NAME="${P/openpbs-/OpenPBS_}"
NAME="${NAME//./_}"
DESCRIPTION="The Portable Batch System (PBS) is a flexible batch queuing and workload management system"
HOMEPAGE="http://www.openpbs.org/"
SRC_URI="${NAME}.tar.gz"

LICENSE="openpbs"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X tcltk crypt doc"
RESTRICT="fetch"

DEPEND="virtual/libc
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tcl )"
RDEPEND="${DEPEND}
		crypt? ( net-misc/openssh )"

S="${WORKDIR}/${NAME}"

pkg_nofetch() {
	einfo "Please visit http://www.openpbs.org/."
	einfo "You must register to download the archive."
	einfo "Place ${A} in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# apply a patch I made for gcc3. 
	# maybe this should be done with sed but I'm too lazy
	epatch ${FILESDIR}/makedepend-sh-gcc3.patch
	epatch ${FILESDIR}/${PF}-errno-fixup.patch
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

	use crypt && myconf="${myconf} --with-scp"
	use doc && myconf="${myconf} --enable-docs"

	./configure ${myconf} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-server \
		--enable-clients \
		--set-server-home=/var/spool/PBS \
		--set-environ=/etc/pbs_environment \
		--enable-mom  || die "./configure failed"

	make || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		PBS_SERVER_HOME=${D}/var/spool/PBS \
		install || die

	dodoc INSTALL PBS_License.text Read.Me Release_Notes
}
