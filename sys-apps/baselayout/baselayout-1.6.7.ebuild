# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.6.7.ebuild,v 1.3 2001/12/08 08:01:19 drobbins Exp $

SV=1.2.1
S=${WORKDIR}/rc-scripts-${SV}
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts)"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/rc-scripts-${SV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

#This ebuild needs to be merged "live".  You can't simply make a package of it and merge it later.

src_compile() {
	cp ${S}/init.d/runscript.c ${T}
	cd ${T}
	gcc ${CFLAGS} runscript.c -o runscript
	echo ${ROOT} > ${T}/ROOT
}

#adds ".keep" files so that dirs aren't auto-cleaned
keepdir() {
	dodir $*
	local x
	for x in $*
	do
		touch ${D}/${x}/.keep
	done
}

src_install()
{
	local foo
	local altmerge
	altmerge=0
	#special ${T}/ROOT hack because ROOT gets automatically unset during src_install()
	#(because it conflicts with some makefiles)
	local ROOT
	ROOT="`cat ${T}/ROOT`"
	#if we are bootstrapping, we want to merge to /dev.
	if [ -z "`use build`" ]
	then
		if [ "$ROOT" = "/" ] && [ "`cat /proc/mounts | grep '/dev devfs'`" ]
		then
			#we're installing to our current system and have devfs enabled.  We'll need to
			#make adjustments
			altmerge=1
		fi
	fi
	keepdir /sbin
	exeinto /sbin
	doexe ${T}/runscript

	keepdir /usr
	keepdir /usr/bin
	keepdir /usr/lib
	keepdir /usr/sbin
	dosbin ${S}/sbin/MAKEDEV ${S}/sbin/run-crons ${S}/sbin/update-modules
	keepdir /var /var/run /var/lock/subsys
	dosym ../var/tmp /usr/tmp
	
	if [ -z "`use bootcd`" ]
	then
		keepdir /boot
		dosym . /boot/boot
		keepdir /home
		keepdir /usr/include /usr/src /usr/portage /usr/X11R6/include/GL
		dosym ../X11R6/include/X11 /usr/include/X11
		dosym ../X11R6/include/GL /usr/include/GL
		
		#dosym ../src/linux/include/linux /usr/include/linux
		#dosym ../src/linux/include/asm-i386 /usr/include/asm
		#Important note: Gentoo Linux 1.0_rc6 no longer uses symlinks to /usr/src for includes.
		#We now rely on the special sys-kernel/linux-headers package, which takes a snapshot of
		#the currently-installed includes in /usr/src and copies them to /usr/include/linux and
		#/usr/include/asm.  This is the recommended approach so that kernel includes can remain
		#constant.  The kernel includes should really only be upgraded when you upgrade glibc.
		keepdir /usr/include/linux /usr/include/asm
		keepdir /usr/share/man /usr/share/info /usr/share/doc /usr/share/misc

		for foo in games lib sbin share bin share/doc share/man src
		do
		  keepdir /usr/local/${foo}
		done
		#local FHS compat symlinks
		dosym share/man /usr/local/man	
		dosym share/doc	/usr/local/doc	

		#FHS compatibility symlinks stuff
		dosym share/man /usr/man
		dosym share/doc /usr/doc
		dosym share/info /usr/info
		keepdir /usr/X11R6/share
		dosym ../../share/info	/usr/X11R6/share/info
		#end FHS compatibility symlinks stuff
		
		doman ${FILESDIR}/MAKEDEV.8 ${S}/man/*
		dodoc ${FILESDIR}/copyright 
		keepdir /usr/X11R6/lib /usr/X11R6/man
		keepdir /var/log/news
		
		#supervise stuff depreciated
		#dodir /var/lib/supervise
		#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/control
		#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/services
		#end supervise stuff
	
		keepdir /opt
	fi

#the .keep file messes up Portage when looking in /var/db/pkg
	dodir /var/db/pkg 
	keepdir /var/spool /var/tmp /var/lib/misc
	chmod 1777 ${D}/var/tmp
	keepdir /root
	
	#/proc is very likely mounted right now so a keepdir will fail on merge
	dodir /proc	
	
	chmod go-rx ${D}/root
	keepdir /tmp
	chmod 1777 ${D}/tmp
	chmod 1777 ${D}/var/tmp
	chown root.uucp ${D}/var/lock
	chmod 775 ${D}/var/lock
	insopts -m0644
	
	insinto /etc
	ln -s ../proc/filesystems ${D}/etc/filesystems
	for foo in hourly daily weekly monthly
	do
		keepdir /etc/cron.${foo}
	done
	for foo in ${S}/etc/*
	do
		#install files, not dirs
		[ -f $foo ] && doins $foo
	done
	#going back to symlink mtab; it just plain works better
	dosym ../proc/mounts /etc/mtab
	chmod go-rwx ${D}/etc/shadow
	keepdir /lib /mnt/floppy /mnt/cdrom
	chmod go-rwx ${D}/mnt/floppy ${D}/mnt/cdrom

#	dosbin rc-update 
#	insinto /usr/bin
#	insopts -m0755
#	doins colors
	if [ $altmerge -eq 1 ]
	then
		#rootfs and devfs
		keepdir /lib/dev-state
		dosym /usr/sbin/MAKEDEV /lib/dev-state/MAKEDEV
		#this is not needed anymore, and causes /sbin/init to lock on
		#boot (the .keep files in /lib/dev-state/{pts,shm})
		#NOTE: this is only when using 'try' with moving /lib/dev-state
		#      to /dev
		#keepdir /lib/dev-state/pts /lib/dev-state/shm
		cd ${D}/lib/dev-state
	else
		#normal
		keepdir /dev
		keepdir /lib/dev-state
		keepdir /dev/pts /dev/shm
		dosym /usr/sbin/MAKEDEV /dev/MAKEDEV
		cd ${D}/dev
	fi	

	# we dont want to create devices if this is not a bootstrap and devfs
	# is used, as this was the cause for all the devfs problems we had
	if [ ! $altmerge -eq 1 ]
	then
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
	fi

	cd ${S}/sbin
	into /
	dosbin init rc rc-update

	#env-update stuff
	keepdir /etc/env.d
	insinto /etc/env.d
	doins ${S}/etc/env.d/00basic
	
	keepdir /etc/modules.d
	insinto /etc/modules.d
	doins ${S}/etc/modules.d/aliases ${S}/etc/modules.d/i386

	keepdir /etc/conf.d
	insinto /etc/conf.d
	for foo in ${S}/etc/conf.d/*
	do
		[ -f $foo ] && doins $foo
	done
	#/etc/conf.d/net.ppp* should only be readible by root
	chmod 0600 ${D}/etc/conf.d/net.ppp*

	#this seems the best place for templates .. any ideas ?
	#NB: if we move this, then $TEMPLATEDIR in net.ppp0 need to be updated as well
	keepdir /etc/ppp
	insinto /etc/ppp
	doins ${S}/etc/ppp/chat-default

	#not the greatest location for this file; should move it on cvs at some	point
	rm ${S}/init.d/runscript.c
	dodir /etc/init.d
	exeinto /etc/init.d
	for foo in ${S}/init.d/*
	do
		[ -f $foo ] && doexe $foo
	done

	dodir /etc/skel
	insinto /etc/skel
	for foo in `find ${S}/etc/skel -type f -maxdepth 1`
	do
		[ -f $foo ] && doins $foo
	done

	#skip this if we are merging to ROOT
	[ "$ROOT" = "/" ] && return
	
	#set up default runlevel symlinks
	local bar
	for foo in default boot nonetwork single
	do
		keepdir /etc/runlevels/${foo}
		for bar in `cat ${S}/rc-lists/${foo}`
		do
			[ -e ${S}/init.d/${bar} ] && dosym /etc/init.d/${bar} /etc/runlevels/${foo}/${bar}
		done
	done

	cat << EOF >> ${D}/etc/hosts
127.0.0.1	localhost
EOF
}

pkg_postinst() {
	#we should only install empty files if these files don't already exist.
	local x
	for x in log/lastlog run/utmp log/wtmp
	do
		[ -e ${ROOT}var/${x} ] || touch ${ROOT}var/${x}
	done

	#kill the old /dev-state directory if it exists
	[ "`mount |grep 'on /dev-state'`" ] && umount /dev-state >/dev/null 2>&1
	[ -e /dev-state ] && rm -rf /dev-state
	
	#remove /lib/dev-state/{pts,shm}, as the .keep files cause init to lock
#	rm -rf /lib/dev-state/{pts,shm} >/dev/null 2>&1
	
	#force update of /etc/devfsd.conf
	#just until everybody upgrade that is ...
	if [ -e /etc/devfsd.conf ]
	then
		mv /etc/devfsd.conf /etc/devfsd.conf.old
		install -m0644 ${S}/etc/devfsd.conf /etc/devfsd.conf

		echo
		echo "*********************************************************"
		echo "* This release use a new form of /dev management, so    *"
		echo "* /etc/devfsd.conf have moved from the devfsd package   *"
		echo "* to this one.  Any old versions will be renamed to     *"
		echo "* /etc/devfsd.conf.old.  Please verify that it actually *"
		echo "* do not save your settings before adding entries, and  *"
		echo "* if you really need to, just add missing entries and   *"
		echo "* try not to delete lines from the new devfsd.conf.     *"
		echo "*********************************************************"
		echo
		
	fi
	
	#restart devfsd
	#we dont want to restart devfsd when bootstrapping, because it will
	#create unneeded entries in /lib/dev-state, which will override the
	#symlinks (to /dev/sound/*, etc) and cause problems.
	if [ -z "`use build`" ]
	then
		if [ "`ps -A |grep devfsd`" ]
		then
			killall -HUP devfsd >/dev/null 2>&1
		elif [ -x /sbin/devfsd ]
		then
			/sbin/devfsd /dev >/dev/null 2>&1
		fi
	fi
}
