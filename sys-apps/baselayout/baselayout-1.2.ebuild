# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.2.ebuild,v 1.1 2000/08/25 02:56:10 drobbins Exp $# Copyright 1999-2000 Gentoo Technologies, Inc.

A=""
S=${WORKDIR}/${P}
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts)"
SRC_URI=""

src_install()
{
	dodir /usr/include
	dosym /var/log /usr/adm
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../src/linux/include/linux /usr/include/linux
	dosym ../src/linux/include/asm-i386 /usr/include/asm
	local foo
	for foo in games man lib sbin share bin doc src
	do
		dodir /usr/local/${foo}
	done
	dodir /usr/man/man8
	doins ${FILESDIR}/MAKEDEV.8.gz /usr/man/man8
	dodir /usr/lib
	dodir /usr/sbin
	doexe ${FILESDIR}/MAKEDEV /usr/sbin
	dodir /usr/share /usr/bin/ /usr/doc
	dodoc ${FILESDIR}/copyright.gz ${FILESDIR}/changelog.Debian.gz
	dodir /usr/X11R6/lib /usr/src/linux/include/linux
	dodir /usr/src/linux/include/asm-i386
	dodir /var /var/run
	touch /var/run/utmp
	dodir /var/lib/locate /var/lib/pkg /var/spool
	dodir /root /opt /home/ftp /etc/modules
	chmod go-rx ${D}/root
	dodir /tmp
	chmod 1777 ${D}/tmp
	insinto /etc
	for foo in services passwd shadow nsswitch.conf inetd.conf ld.so.conf pam.conf protocols fstab hosts syslog.conf pwdb.conf filesystems group profile
	do
		doins ${FILESDIR}/${foo} /etc
	done
	chmod go-rwx ${D}/etc/shadow
	dosym /usr/sbin/MAKEDEV /dev/MAKEDEV
	dodir /dev/pts /lib /proc /mnt/floppy /mnt/cdrom
	chmod go-rwx ${D}/mnt/floppy ${D}/mnt/cdrom
}





