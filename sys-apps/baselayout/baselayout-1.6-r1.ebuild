# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.6-r1.ebuild,v 1.5 2001/08/21 05:30:01 drobbins Exp $

SV=1.1.2
S=${WORKDIR}/rc-scripts-${SV}
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts)"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/rc-scripts-${SV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"
#if [ -z "`use bootcd`" ]
#then
#	INIT_D_SCRIPTS="bootmisc checkfs checkroot clock halt hostname
#                    inet initscripts-install isapnp keymaps local
#                    modules mountall mountall.test pretty rc reboot
#                    rmnologin sendsigs serial single umountfs urandom
#                    vcron"
#else
#	INIT_D_SCRIPTS="cdboot cdscan"
#fi

src_compile() {
	cp ${S}/init.d/runscript.c ${T}
	cd ${T}
	gcc ${CFLAGS} runscript.c -o runscript
}

src_install()
{
	local foo
	if [ "$MAINTAINER" != "yes" ] && [ "$ROOT" = "/" ]
	then
		echo '!!! baselayout should only be merged if you know what youre doing.'
		echo '!!! It will overwrite important system files (passwd/group and others) with their'
		echo '!!! original versions.  For now, please update your files by hand by'
		echo '!!! comparing the contents of the files in '${FILESDIR}' to your'
		echo '!!! installed versions.  We will have an automated update system shortly.'
		exit 1
	fi
	dodir /sbin
	exeinto /sbin
	doexe ${T}/runscript

	dodir /usr
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/sbin
	dosbin ${S}/sbin/MAKEDEV ${S}/sbin/run-crons ${S}/sbin/update-modules
	dodir /var /var/run /var/lock/subsys
	dosym ../var/tmp /usr/tmp
	
	if [ -z "`use bootcd`" ]
	then
		#new boot partition layout: boot partition should now be mounted at /mnt/boot
		dodir /mnt/boot
		#this next line adds easy detection for when /mnt/boot isn't mounted
		touch ${D}/mnt/boot/boot
		dosym mnt/boot/boot /boot
		#with the symlink, kernel can be found at /boot/bzImage, grub at /boot/grub.

		dodir /home
		dodir /usr/include /usr/src /usr/portage /usr/X11R6/include/GL
		dosym ../X11R6/include/X11 /usr/include/X11
		dosym ../X11R6/include/GL /usr/include/GL
		
		#dosym ../src/linux/include/linux /usr/include/linux
		#dosym ../src/linux/include/asm-i386 /usr/include/asm
		#Important note: Gentoo Linux 1.0_rc6 no longer uses symlinks to /usr/src for includes.
		#We now rely on the special sys-kernel/linux-headers package, which takes a snapshot of
		#the currently-installed includes in /usr/src and copies them to /usr/include/linux and
		#/usr/include/asm.  This is the recommended approach so that kernel includes can remain
		#constant.  The kernel includes should really only be upgraded when you upgrade glibc.
		dodir /usr/include/linux /usr/include/asm
		dodir /usr/share/man /usr/share/info /usr/share/doc /usr/share/misc

		for foo in games lib sbin share bin share/doc share/man src
		do
		  dodir /usr/local/${foo}
		done
		#local FHS compat symlinks
		dosym share/man /usr/local/man	
		dosym share/doc	/usr/local/doc	

		#FHS compatibility symlinks stuff
		dosym share/man /usr/man
		dosym share/doc /usr/doc
		dosym share/info /usr/info
		dodir /usr/X11R6/share
		dosym ../../share/info	/usr/X11R6/share/info
		#end FHS compatibility symlinks stuff
		
		doman ${FILESDIR}/MAKEDEV.8
		dodoc ${FILESDIR}/copyright ${FILESDIR}/changelog.Debian
		dodir /usr/X11R6/lib /usr/X11R6/man
		dodir /var/log/news
		
		#supervise stuff depreciated
		#dodir /var/lib/supervise
		#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/control
		#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/services
		#end supervise stuff
		
		dodir /opt

#		It makes sense to move these to the PAM package.
#		dodir /etc/pam.d
#		cd ${FILESDIR}/pam.d
#		insinto /etc/pam.d
#		doins *
	fi
	
	touch ${D}/var/log/lastlog
	touch ${D}/var/run/utmp
	touch ${D}/var/log/wtmp
	dodir /var/db/pkg /var/spool /var/tmp /var/lib/misc
	chmod 1777 ${D}/var/tmp
	dodir /root /proc
	
	chmod go-rx ${D}/root
	dodir /tmp
	chmod 1777 ${D}/tmp
	chmod 1777 ${D}/var/tmp
	chown root.uucp ${D}/var/lock
	chmod 775 ${D}/var/lock
	insopts -m0644
	
	insinto /etc
	ln -s ../proc/filesystems ${D}/etc/filesystems
	for foo in hourly daily weekly monthly
	do
		dodir /etc/cron.${foo}
	done
	for foo in ${S}/etc/*
	do
		#install files, not dirs
		[ -f $foo ] && doins $foo
	done
	
	chmod go-rwx ${D}/etc/shadow
	dodir /lib /proc /mnt/floppy /mnt/cdrom
	chmod go-rwx ${D}/mnt/floppy ${D}/mnt/cdrom

#	dosbin rc-update 
#	insinto /usr/bin
#	insopts -m0755
#	doins colors
  	dodir /dev
	dodir /dev-state
	dodir /dev/pts /dev/shm
	dosym /usr/sbin/MAKEDEV /dev/MAKEDEV
	cd ${D}/dev
	#These devices are also needed by many people and should be included
	echo "Making device nodes... (this could take a minute or so...)"
	${S}/sbin/MAKEDEV generic-i386
	${S}/sbin/MAKEDEV sg
	${S}/sbin/MAKEDEV scd
	${S}/sbin/MAKEDEV rtc 
	${S}/sbin/MAKEDEV audio
	${S}/sbin/MAKEDEV hde
	${S}/sbin/MAKEDEV hdf
	${S}/sbin/MAKEDEV hdg
	${S}/sbin/MAKEDEV hdh

#end env-update stuff
	cd ${S}/sbin
	into /
	dosbin init rc

	#env-update stuff
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${S}/etc/env.d/00basic
	
	dodir /etc/modutils
	insinto /etc/modutils
	doins ${S}/etc/modutils/aliases ${S}/etc/modutils/i386

	dodir /etc/init.d
	exeinto /etc/init.d
	for foo in ${S}/init.d/*
	do
		[ -f $foo ] && doexe $foo
	done
	#not the greatest location for this file; should move it at some point
	rm ${S}/etc/init.d/runscript.c

	#set up default runlevel symlinks
	local bar
	for foo in default boot nonetwork single
	do
		dodir /etc/runlevels/${foo}
		for bar in `cat ${S}/rc-lists/${foo}`
		do
			[ -e ${S}/init.d/${bar} ] && dosym /etc/init.d/${bar} /etc/runlevels/${foo}/${bar}
		done
	done

	#default make.profile symlink; handy for doing bootstraps, etc.
	dosym /usr/portage/profiles/default /etc/make.profile

}
