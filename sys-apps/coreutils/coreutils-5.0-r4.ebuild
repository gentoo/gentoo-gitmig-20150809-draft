# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils/coreutils-5.0-r4.ebuild,v 1.2 2003/09/12 11:35:20 seemant Exp $

inherit eutils

IUSE="nls build acl selinux"

PATCH_VER=1.5

S="${WORKDIR}/${P}"
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls...), text utilities (sort, tr, head, wc..), and shell utilities (whoami, who,...)"
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="http://ftp.gnu.org/pub/gnu/coreutils/${P}.tar.bz2
	mirror://gentoo/${PN}-gentoo-${PATCH_VER}.tar.bz2
	selinux? mirror://gentoo/${P}-r2-selinux.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc alpha hppa ~arm ~mips"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.49
	nls? ( sys-devel/gettext )
	selinux? ( >=sys-apps/selinux-small-2003011510-r2 )"

PATCHDIR=${WORKDIR}/patch

src_unpack() {
	unpack ${A}
	cd ${S}

	if use acl && use selinux
	then
		ewarn "Both ACL and SELINUX are not supported together!"
		ewarn "Will Select SELINUX instead"
	fi

	# HPPA and ARM platforms do not work well with the uname patch
	# (see below about it)
	if use hppa || use arm
	then
		mv ${PATCHDIR}/004* ${PATCHDIR}/excluded
	fi

	# Apply the ACL patches. 
	# WARNING: These CONFLICT with the SELINUX patches
	if use acl
	then
		mv ${PATCHDIR}/001* ${PATCHDIR}/excluded
		use selinux || EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/acl
	fi

	# patch to remove Stallman's su/wheel group rant (which doesn't apply,
	# since Gentoo's su is not GNU/su, but that from shadow.
	# do not include su infopage, as it is not valid for the su
	# from sys-apps/shadow that we are using.
	# Patch to add processor specific info to the uname output

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	use selinux && epatch ${WORKDIR}/${P}-r2-selinux.patch

}

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"

	econf \
		--bindir=/bin \
		${myconf} || die

	if [ "`use static`" ]
	then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
}

src_install() {
	einstall \
		bindir=${D}/bin || die

	# hostname comes from net-base
	# hostname does not work with the -f switch, which breaks gnome2
	#   amongst other things
	rm -f ${D}/{bin,usr/bin}/hostname ${D}/usr/share/man/man1/hostname.*

	# /bin/su comes from sys-apps/shadow
	rm -f ${D}/{bin,usr/bin}/su ${D}/usr/share/man/man1/su.*

	# /usr/bin/uptime comes from the sys-apps/procps packaga
	rm -f ${D}/{bin,usr/bin}/uptime ${D}/usr/share/man/man1/uptime*

	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib
	cd usr/bin
	ln -s ../../bin/* .

	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc AUTHORS ChangeLog* COPYING NEWS README* THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postinst() {
	# hostname does not get removed as it is included with older stage1
	# tarballs, and net-tools installs to /bin
	if [ -e ${ROOT}/usr/bin/hostname ] && [ ! -L ${ROOT}/usr/bin/hostname ]
	then
		rm -f ${ROOT}/usr/bin/hostname
	fi
}
