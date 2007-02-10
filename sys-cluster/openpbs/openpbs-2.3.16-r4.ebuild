# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openpbs/openpbs-2.3.16-r4.ebuild,v 1.3 2007/02/10 23:33:53 opfer Exp $

inherit eutils multilib

NAME="${P/openpbs-/OpenPBS_}"
NAME="${NAME//./_}"
DESCRIPTION="The Portable Batch System (PBS) is a flexible batch queuing and workload management system"
HOMEPAGE="http://www.openpbs.org/"
SRC_URI="${NAME}.tar.gz"

LICENSE="openpbs"
PROVIDE="virtual/pbs"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X tcl crypt doc"
RESTRICT="fetch"

PROVIDE="virtual/pbs"
DEPEND="virtual/libc
		X? ( || ( x11-libs/libX11 virtual/x11 ) )
		tcl? ( dev-lang/tcl )
		sys-apps/ed
		!virtual/pbs"
RDEPEND="${DEPEND}
		crypt? ( net-misc/openssh )"
PDEPEND="sys-cluster/openpbs-common"

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
	epatch ${FILESDIR}/openpbs-${PV}-errno-fixup.patch
	epatch ${FILESDIR}/openpbs-gcc32.patch
	# this thing doesn't use make install, but rather it's own install script
	# fix it here so the install dirs are set to the ${D} directory
	pushd buildutils
	mv pbs_mkdirs.in pbs_mkdirs.in-orig
	sed -e "s|prefix=@prefix@|prefix=\${D}@prefix@| ; \
			s|PBS_SERVER_HOME=@PBS_SERVER_HOME@|PBS_SERVER_HOME=\${D}@PBS_SERVER_HOME@| ; \
			s|PBS_DEFAULT_FILE=@PBS_DEFAULT_FILE@|PBS_DEFAULT_FILE=\${D}@PBS_DEFAULT_FILE@| ; \
			s|PBS_ENVIRON=@PBS_ENVIRON@|PBS_ENVIRON=\${D}@PBS_ENVIRON@| ; \
			s|PBS_LIB=@libdir@|PBS_LIB=\${D}@libdir@|" \
			pbs_mkdirs.in-orig > pbs_mkdirs.in
	popd

	# Patch from SuSE srpm, found on rpmfind.net
	epatch ${FILESDIR}/${PV}-gcc4.patch

	# (#119479) lam-mpi shared lib links against libpbs.a so it needs -fPIC
	epatch ${FILESDIR}/${PV}-build-fpic-static-libpbs.patch
}

src_compile() {
	local myconf
	use X || myconf="--disable-gui"
	use tcl && myconf="${myconf} --with-tcl"

	use crypt && myconf="${myconf} --with-scp"
	use doc && myconf="${myconf} --enable-docs"

	./configure ${myconf} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--libdir=/usr/$(get_libdir)/pbs/lib \
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
		libdir=${D}/usr/$(get_libdir)/pbs/lib \
		PBS_SERVER_HOME=${D}/var/spool/PBS \
		install || die

	dosed /usr/bin/xpbs /usr/bin/xpbsmon

	#
	# if we are using tcl, we need to fix up the tclIndex so that it will
	# refer to the tcl library where it is installed, not where we have staged
	# it.
	for tcldir in xpbs xpbsmon; do
		if [ -e ${D}/usr/$(get_libdir)/pbs/lib/${tcldir}/tclIndex ]; then
			einfo "Patch in place the ${tcldir}/tclIndex to match our installation"
			sed -i -e "s|\$dir .* usr $(get_libdir) pbs lib ${tcldir}|\$dir|g" ${D}/usr/$(get_libdir)/pbs/lib/${tcldir}/tclIndex
		else
				ewarn "We can't find ${tcldir}/tclIndex to fix!"
		fi
	done

	dodoc INSTALL PBS_License.text Read.Me Release_Notes
}
