# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils/coreutils-5.0-r5.ebuild,v 1.7 2004/01/09 08:25:43 seemant Exp $

inherit eutils

IUSE="nls build static"

PATCH_VER=1.8.1

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls...), text utilities (sort, tr, head, wc..), and shell utilities (whoami, who,...)"
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="http://ftp.gnu.org/pub/gnu/coreutils/${P}.tar.bz2
	mirror://gentoo/${PN}-gentoo-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~seemant/extras/${PN}-gentoo-${PATCH_VER}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha hppa arm mips ~amd64"

DEPEND=">=sys-apps/portage-2.0.49
	sys-devel/automake
	sys-devel/autoconf
	nls? ( sys-devel/gettext )"

RDEPEND=""

# the sandbox code in portage-2.0.48 causes breakage
export SANDBOX_DISABLED="1"

PATCHDIR=${WORKDIR}/${PN}-gentoo-patches

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${PATCHDIR}/${PN}-progress-bar.patch

	# su, kill, hostname, groups, and uptime are provided by procps and/or
	# util-linux.  Thus, these are prevented from building, and also
	# Stallman's rant is removed from su info since we use su from shadow
	# package
	epatch ${PATCHDIR}/${P}-gentoo-remove-su-hostname-groups-kill-uptime.patch

	# Patch to add processor specific info to the uname output
	if [ -z "`use hppa`" ] && [ -z "`use arm`" ]
	then
		epatch ${PATCHDIR}/${PN}-gentoo-uname.patch
	fi

	# Patch to remove installation of man pages for which the  man-pages 
	# package provides superior versions
	epatch ${PATCHDIR}/${PN}-manpages.patch
}

src_compile() {
	aclocal -I ${S}/m4 || die
	autoconf || die
	automake || die

	econf \
		--bindir=/bin \
		`use_enable nls` || die

	if [ "`use static`" ]
	then
		emake LDFLAGS=-static all || die
	else
		emake all || die
	fi
}

src_install() {
	einstall \
		bindir=${D}/bin || die

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

	einfo "Please remove textutils, fileutils and sh-utils from your system"
	einfo "As they are deprecated by coreutils"
}
