# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Id: quik-2.0.1.0-r1.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

S="${WORKDIR}/quik-2.0"
A="quik_2.0e.orig.tar.gz"

echo "workdir is:"
echo ${WORKDIR}
HOMEPAGE=""
SLOT="0"
LICENSE="GPL-2"
DEB_P="quik_2.0e-1.diff"
DEB_URI="ftp://ftp.debian.org/debian/pool/main/q/quik"

DESCRIPTION="OldWorld PowerMac Bootloader"

SRC_URI="${DEB_URI}/${A} ${DEB_URI}/${DEB_P}.gz"

DEPEND="virtual/glibc"
RDEPEND=""
KEYWORDS="ppc"

pkg_setup() {
	[ "${ROOT}" != "/" ] && return 0
	. ${ROOT}/etc/init.d/functions.sh
	local fstabstate="$(cat /etc/fstab |grep -v -e '#' |awk '{print $2}')"
	local procstate="$(cat /proc/mounts |awk '{print $2}')"
	if [ -n "$(echo ${fstabstate} |grep -e "/boot")" ] && \
	   [ -n "$(echo ${procstate} |grep -e "/boot")" ]
	then
		einfo "Your boot partition was detected as being mounted as /boot."
		einfo "Files will be installed there for this bootloader to function correctly."
	elif [ -n "$(echo ${fstabstate} |grep -e "/boot")" ] && \
	     [ -z "$(echo ${procstate} |grep -e "/boot")" ]
	then
		mount /boot &>/dev/null
		if [ "$?" -eq 0 ]
		then
			einfo "Your boot partition was not mounted as /boot, but portage was able to mount"
			einfo "it without additional intervention."
			einfo "Files will be installed there for this bootloader to function correctly."
		else
			eerror "Your boot partition has to be mounted on /boot before the installation"
			eerror "can continue. This bootloader needs to install important files there."
			die "Please mount your /boot partition."
		fi
	else
		einfo "You do not have a seperate /boot partition."
	fi
}

src_unpack() {
	cd ${WORKDIR}
	unpack ${A} || die
	zcat ${DISTDIR}/${DEB_P}.gz | patch -p1 -d ${S}|| die
}

src_compile() {
	emake || die
}

src_install () {

	# 'll have a look at this later

	install -d -m 755 ${D}/sbin || die
	install -d -m 755 ${D}/etc || die
	install -d -m 755 ${D}/boot || die
	install -d -m 755 ${D}/usr/share/man/man5 || die
	install -d -m 755 ${D}/usr/share/man/man8 || die
	install -s -m 755 quik/quik ${D}/sbin || DIE
	install -m 644 man/quik.conf.5 \
			${D}/usr/share/man/man5 || DIE
	install -m 644 man/quik.8 man/bootstrap.8 \
			${D}/usr/share/man/man8 || DIE

	install -m 444 first/first.b second/second.b	\
					second/second ${D}/boot || die
	install -m 644 etc/quik.conf ${D}/etc || die
}
