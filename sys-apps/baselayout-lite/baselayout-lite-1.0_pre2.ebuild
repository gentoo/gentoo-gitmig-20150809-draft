# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-lite/baselayout-lite-1.0_pre2.ebuild,v 1.4 2005/06/08 17:51:26 solar Exp $

inherit toolchain-funcs

IUSE="build bootstrap"

DESCRIPTION="Baselayout for embedded systems"
HOMEPAGE="http://www.gentoo.org/proj/en/base/embedded/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~iggy/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"

PROVIDE="virtual/baselayout"
RDEPEND="!virtual/baselayout"
DEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
	# the new tarball has the layout we want, just copy it straight to the 
	# output dir
	cp -a ${S}/image/* ${D}
	find ${D} -name CVS -exec rm -rf {} \;

	[ -f $ROOT/proc/cpuinfo ] && rm -f ${D}/proc/.keep
	use elibc_uclibc && rm -f ${D}/etc/nsswitch.conf
	chmod 755 ${D}/etc/init.d/*

	# compile the few things that need to be
	cd ${S}/src
	emake CC="$(tc-getCC)" || die "failed to compile the bits and pieces"
	into /
	dosbin rc runscript

	# device node creation stuff
	cd ${D}/dev || die
	einfo "Making device nodes (this could take a minute or so...)"

	MAKEDEV std
	mknod -m 0600 console c 5 1
	for i in 0 1 2 3 4; do
		mknod -m 0660 hda${i/0} b 3 ${i}
		mknod -m 0660 sda${i/0} b 8 ${i}
		mknod -m 0660 cfa${i/0} b 13 ${i}
		chown root:disk hda${i/0} sda${i/0}
		mknod -m 0600 tty${i} c 4 ${i}
		chown root:tty tty${i}
	done

	MAKEDEV ttyS0
}

pkg_postinst() {
	# Touching /etc/passwd and /etc/shadow after install can be fatal, as many
	# new users do not update them properly.  thus remove all ._cfg files if
	# we are not busy with a build.
	if ! ( use build || use bootstrap )
	then
		ewarn "Removing invalid backup copies of critical config files..."
		rm -f ${ROOT}/etc/._cfg????_{passwd,shadow}
	fi

	# Doing device node creation here, since portage doesnt record
	# device nodes in CONTENTS

	# (Jul 23 2004 -solar)
	# Moved device node creation to src_install() so that we can get
	# the device nods into a binary package which can then be
	# installed on a host which does not have python/portage etc.
}
