# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.3.ebuild,v 1.5 2000/11/15 01:48:27 drobbins Exp $# Copyright 1999-2000 Gentoo Technologies, Inc.

A=""
S=${WORKDIR}/${P}
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts)"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"

src_install()
{
	dodir /boot
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
	doman ${FILESDIR}/MAKEDEV.8
	dodir /usr/lib
	dodir /usr/sbin
	dosbin ${FILESDIR}/MAKEDEV ${FILESDIR}/run-crons
	dodir /dev
  	dodir /dev/pts
	dosym /usr/sbin/MAKEDEV /dev/MAKEDEV
	dodir /usr/share /usr/bin/ /usr/doc
	dodoc ${FILESDIR}/copyright ${FILESDIR}/changelog.Debian
	dodir /usr/X11R6/lib /usr/src/linux/include/linux
	dodir /usr/src/linux/include/asm-i386
	dodir /var /var/run /var/log/news
	touch ${D}/var/run/utmp
	touch ${D}/var/log/wtmp
	dodir /var/lib/locate /var/lib/pkg /var/spool
	dodir /root /opt /home/ftp /etc/modules /proc
	chmod go-rx ${D}/root
	dodir /tmp
	chmod 1777 ${D}/tmp
	insopts -m0644
	insinto /etc
	for foo in services passwd shadow nsswitch.conf inetd.conf ld.so.conf pam.conf protocols fstab hosts syslog.conf pwdb.conf filesystems group profile crontab
	do
		doins ${FILESDIR}/${foo}
	done
        for foo in hourly daily weekly monthly
	do
		dodir /etc/cron.$foo
	done
	chmod go-rwx ${D}/etc/shadow
	dodir /dev/pts /lib /proc /mnt/floppy /mnt/cdrom
	chmod go-rwx ${D}/mnt/floppy ${D}/mnt/cdrom

	for x in boot halt 1 2 3 4 5 
	do
	    dodir /etc/rc.d/rc${x}.d
	done
        dosym rcboot.d /etc/rc.d/rc0.d
        dosym rchalt.d /etc/rc.d/rc6.d

	dodir /etc/rc.d/init.d
	dodir /etc/rc.d/config
	cd ${FILESDIR}/rc.d/init.d
	exeinto /etc/rc.d/init.d
	doexe *
	insinto /etc/rc.d/init.d/extra_scripts
	cd ${FILESDIR}/rc.d/config
	insinto /etc/rc.d/config
        doins *
	doins runlevels
	cd ${FILESDIR}
	insinto /etc
	doins inittab
	into /usr
	dosbin rc-update
	insinto /usr/bin
	insopts -m0755
	doins colors
	dodir /dev
	cd ${D}/dev
	MAKEDEV generic-i386
        MAKEDEV sg
        MAKEDEV scd
        MAKEDEV rtc 
	dodoc README.newusers blurb.txt
	cd ${D}/etc/rc.d/config
	cp runlevels runlevels.orig
	sed -e 's:##OSNAME##:Gentoo Linux:g' -e 's:##ARCH##:i686a:g' runlevels.orig > runlevels
	rm runlevels.orig
}








