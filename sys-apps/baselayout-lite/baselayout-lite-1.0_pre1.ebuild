# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-lite/baselayout-lite-1.0_pre1.ebuild,v 1.14 2007/06/26 02:45:55 mr_bones_ Exp $

DESCRIPTION="Baselayout for embedded systems"
HOMEPAGE="http://www.gentoo.org/proj/en/base/embedded/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="build bootstrap"

#PROVIDE="virtual/baselayout"
#DEPEND="!virtual/baselayout"

S="${WORKDIR}/${PN}"
PROVIDE="virtual/baselayout"

src_install() {
	keepdir /bin /etc /etc/init.d /home /lib /sbin /usr /var /root /mnt
	keepdir /var/log /proc /dev/pts

	# if ROOT=/ and we make /proc, we will get errors when portage tries
	# to create /proc/.keep, so we remove it if we need to
	[ "${ROOT}" = "/" ] && rm -rf ${D}/proc
	[ "${ROOT}" = "" ] && rm -rf ${D}/proc

	# (Jul 23 2004 -solar)
	# This fails a when merging if /proc is already mounted. We
	# could postinst it but 99% of the time we only are building
	# this port as a package via emerge -B
	#keepdir /proc

	insinto /etc
	doins ${S}/{fstab,group,passwd,profile.env,protocols,shells}

	# Fixup fstab for devpts support
	dosed "7i devpts	/dev/pts	devpts	defaults	0 0"

	# Fixup the inittab file first
	sed -i -e 's:/usr/bin/tail:/bin/tail:' ${S}/init/inittab
	doins ${S}/init/inittab

	doinitd ${S}/init/rc[SK]

	mkdir -p ${D}/dev

	cd ${D}/dev || die
	einfo "Making device nodes (this could take a minute or so...)"

	MAKEDEV std
	mknod -m 0600 console c 5 1
	mknod ptmx c 5 2

	for i in 0 1 2 3 4; do
		mknod -m 0660 hda${i/0} b 3 ${i}
		mknod -m 0660 sda${i/0} b 8 ${i}
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
