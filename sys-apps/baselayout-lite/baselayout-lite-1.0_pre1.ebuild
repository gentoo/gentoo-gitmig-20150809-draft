# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-lite/baselayout-lite-1.0_pre1.ebuild,v 1.2 2004/02/27 20:21:45 pebenito Exp $

IUSE=""

DESCRIPTION="Baselayout for embedded systems"
HOMEPAGE="http://www.gentoo.org/proj/en/base/embedded/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"

S="${WORKDIR}/${PN}"

src_install() {
	keepdir /bin /etc /etc/init.d /home /lib /sbin /usr /var /proc /root /mnt

	insinto /etc
	doins ${S}/{fstab,group,nsswitch.conf,passwd,profile.env,protocols,shells}
	doins ${S}/init/inittab

	exeinto /etc/init.d
	doexe ${S}/init/rc[SK]
}

pkg_postinst() {
	# Doing device node creation here, since portage doesnt record
	# device nodes in CONTENTS

	cd ${ROOT}/dev
	einfo "Making device nodes (this could take a minute or so...)"

	MAKEDEV std
	mknod -m 0600 console c 5 1

	for i in 0 1 2 3 4; do
		mknod -m 0660 hda${i/0} b 3 ${i}
		chown root:disk hda${i/0}
		mknod -m 0600 tty${i} c 4 ${i}
		chown root:tty tty${i}
	done

	MAKEDEV ttyS0

	# Touching /etc/passwd and /etc/shadow after install can be fatal, as many
	# new users do not update them properly.  thus remove all ._cfg files if
	# we are not busy with a build.
	if [ -z "`use build`" -a -z "`use bootstrap`" ]
	then
		ewarn "Removing invalid backup copies of critical config files..."
		rm -f ${ROOT}/etc/._cfg????_{passwd,shadow}
	fi
}

