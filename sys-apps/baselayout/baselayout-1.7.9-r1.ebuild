# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.7.9-r1.ebuild,v 1.7 2002/08/18 16:41:05 murphy Exp $

SV="1.3.5"
SVREV=""
#sysvinit version
SVIV="2.83"
S=${WORKDIR}/rc-scripts-${SV}
S2=${WORKDIR}/sysvinit-${SVIV}/src
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts and sysvinit)"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/init/sysvinit-${SVIV}.tar.gz"
#	http://www.ibiblio.org/gentoo/distfiles/rc-scripts-${SV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"

SLOT="0"

DEPEND="sys-kernel/linux-headers"
RDEPEND=""
#baselayout shouldn't have any runtime dependencies.  it creates circular deps fast.
#if [ -z "`use build`" ]
#then
#	RDEPEND="sys-apps/kbd"
#fi

#This ebuild needs to be merged "live".  You can't simply make a package of it and merge it later.

pkg_setup() {
	if [ "$ROOT" = "/" ]
	then
		#make sure we do not kill X because of the earlier bad /etc/inittab we used.
		source /etc/init.d/functions.sh || die
		if [ -L ${svcdir}/started/xdm ] && \
		   [ -n "`grep -e 'x:3:respawn:/etc/X11/startDM.sh' /etc/inittab`" ] && \
		   [ -n "`ps -A | grep -e "X"`" ]
		then
			echo
		   	einfo "!!! With the current version of baselayout installed (1.7.3-r1), merging"
			einfo "    this version of baselayout will cause X to die if you started it"
			einfo "    with the /etc/init.d/xdm script!!!!"
			echo
			einfo "Please quit X and then merge this again."
			die
		fi
	fi
}

src_unpack() {
	unpack ${A}

	echo ">>> Unpacking rc-scripts-${SV}${SVREV}.tar.bz2"
	tar -jxf ${FILESDIR}/rc-scripts-${SV}${SVREV}.tar.bz2 || die

	#fix CFLAGS for sysvinit stuff
	cd ${S2}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig >Makefile || die
	if [ -n "`use build`" ]
	then
		#do not build sulogin, as it needs libcrypt which is not in the
		#build image.
		cp Makefile Makefile.orig
		sed -e 's:PROGS\t= init halt shutdown killall5 runlevel sulogin:PROGS\t= init halt shutdown killall5 runlevel:g' \
			Makefile.orig >Makefile || die
	fi
	
	# Fix Sparc specific stuff
	if [ "${ARCH}" == "sparc" -o "${ARCH}" == "sparc64" ]; then
		cd ${S}/etc
		cp rc.conf rc.conf.orig
		sed -e 's:KEYMAP="us":KEYMAP="sun":' rc.conf.orig >rc.conf || die
		rm rc.conf.orig

		cp inittab inittab.orig
		sed -e 's"# TERMINALS"# SERIAL CONSOLE\nc0:12345:respawn:/sbin/agetty 9600 ttyS0 linux\n\n# TERMINALS"' \
			inittab.orig >inittab || die
		rm inittab.orig
	fi
}

src_compile() {
	cp ${S}/sbin/runscript.c ${T}
	cp ${S}/sbin/start-stop-daemon.c ${T}

	cd ${T}
	gcc ${CFLAGS} runscript.c -o runscript || die "cant compile runscript.c"
	gcc ${CFLAGS} start-stop-daemon.c -o start-stop-daemon || die "cant compile start-stop-daemon.c"
	echo ${ROOT} > ${T}/ROOT

	if [ -z "`use build`" ]
	then
		# build sysvinit stuff
		cd ${S2}
		emake LDFLAGS="" || die "problem compiling sysvinit"
	fi
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

defaltmerge() {
	#define the "altmerge" variable.
	altmerge=0
	#special ${T}/ROOT hack because ROOT gets automatically unset during src_install()
	#(because it conflicts with some makefiles)
	local ROOT
	ROOT="`cat ${T}/ROOT`"
	if [ -z "`use bootstrap`" ] && [ -z "`use build`" ] &&  [ -e ${ROOT}/dev/.devfsd ]
	then
		# we're installing to a system that has devfs enabled; don't create device
		# nodes.
		altmerge=1
	fi
}


src_install()
{
	local foo
	defaltmerge
	keepdir /sbin
	exeinto /sbin
	doexe ${T}/runscript
	doexe ${T}/start-stop-daemon

	keepdir /usr
	keepdir /usr/bin
	keepdir /usr/lib
	keepdir /usr/sbin
	#dont install run-crons anymore, as sys-apps/cronbase installs it now
	#dosbin ${S}/sbin/MAKEDEV ${S}/sbin/run-crons ${S}/sbin/update-modules
	dosbin ${S}/sbin/MAKEDEV ${S}/sbin/update-modules
	keepdir /var /var/run /var/lock/subsys
	dosym ../var/tmp /usr/tmp
	
	keepdir /home
	keepdir /usr/include /usr/src /usr/portage /usr/X11R6/include/{X11,GL}
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
	dodoc ${S}/ChangeLog
	keepdir /usr/X11R6/lib /usr/X11R6/man
	keepdir /var/log/news

	#supervise stuff depreciated
	#dodir /var/lib/supervise
	#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/control
	#install -d -m0750 -o root -g wheel ${D}/var/lib/supervise/services
	#end supervise stuff
	
	keepdir /opt

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
	chmod go-rwx ${D}/etc/shadow
	keepdir /lib /mnt/floppy /mnt/cdrom
	chmod go-rwx ${D}/mnt/floppy ${D}/mnt/cdrom

	#dont add a new /etc/{passwd,shadow} if they exist
	[ -f ${ROOT}/etc/passwd ] && rm -f ${D}/etc/passwd
	[ -f ${ROOT}/etc/shadow ] && rm -f ${D}/etc/shadow

#	dodir /etc/X11
#	exeinto /etc/X11
#	doexe ${S}/sbin/startDM.sh

	keepdir /lib/dev-state
	if [ $altmerge -eq 1 ]
	then
		#rootfs and devfs
		dosym /usr/sbin/MAKEDEV /lib/dev-state/MAKEDEV
		#this is not needed anymore...
		#keepdir /lib/dev-state/pts /lib/dev-state/shm
	else
		#normal
		keepdir /dev
		keepdir /dev/pts /dev/shm
		dosym /usr/sbin/MAKEDEV /dev/MAKEDEV
	fi	

	cd ${S}/sbin
	into /
	dosbin rc rc-update

	if [ -z "`use build`" ]
	then
		#install sysvinit stuff
		cd ${S2}
		into /
		dosbin init halt killall5 runlevel shutdown sulogin
		dosym init /sbin/telinit
		dobin last mesg utmpdump wall
		dosym killall5 /sbin/pidof
		dosym halt /sbin/reboot

		#sysvinit docs
		cd ${S2}/../
		doman man/*.[1-9]
		docinto sysvinit-${SVIV}
		dodoc COPYRIGHT README doc/*
	fi

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
#	chmod 0600 ${D}/etc/conf.d/net.ppp*

	#this seems the best place for templates .. any ideas ?
	#NB: if we move this, then $TEMPLATEDIR in net.ppp0 need to be updated as well
	keepdir /etc/ppp
	insinto /etc/ppp
	doins ${S}/etc/ppp/chat-default

	dodir /etc/init.d
	exeinto /etc/init.d
	for foo in ${S}/init.d/*
	do
		[ -f $foo ] && doexe $foo
	done
	#/etc/init.d/net.ppp* should only be readible by root
	chmod 0600 ${D}/etc/init.d/net.ppp*

	#these moved from /etc/init.d/ to /sbin to help newb systems
	#from breaking
	exeinto /sbin
	doexe ${S}/sbin/depscan.sh
	doexe ${S}/sbin/runscript.sh
	doexe ${S}/sbin/functions.sh
	doexe ${S}/sbin/rc-envupdate.sh
	doexe ${S}/sbin/rc-help.sh
	#compat symlinks (some stuff have hardcoded paths)
	dosym /sbin/depscan.sh /etc/init.d/depscan.sh
	dosym /sbin/runscript.sh /etc/init.d/runscript.sh
	dosym /sbin/functions.sh /etc/init.d/functions.sh

	dodir /etc/skel
	insinto /etc/skel
	for foo in `find ${S}/etc/skel -type f -maxdepth 1`
	do
		[ -f $foo ] && doins $foo
	done

	#make sure our ${svcdir} exists
	source ${D}/etc/init.d/functions.sh
	keepdir ${svcdir} >/dev/null 2>&1

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

}

pkg_preinst() {
	#make sure symlinks of these get installed.
	if [ -e ${ROOT}/etc/init.d/depscan.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/depscan.sh ]
	then
		rm -f ${ROOT}/etc/init.d/depscan.sh
	fi
	if [ -e ${ROOT}/etc/init.d/runscript.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/runscript.sh ]
	then
		rm -f ${ROOT}/etc/init.d/runscript.sh
	fi
	if [ -e ${ROOT}/etc/init.d/functions.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/functions.sh ]
	then
		rm -f ${ROOT}/etc/init.d/functions.sh
	fi
	if [ -e ${ROOT}/etc/init.d/rc-help.sh ]
	then
		rm -f ${ROOT}/etc/init.d/rc-help.sh
	fi
}

pkg_postinst() {
	#doing device node creation in pkg_postinst() now so they aren't recorded in CONTENTS.
	#latest CVS-only version of Portage doesn't record device nodes in CONTENTS at all.
	defaltmerge
	# we dont want to create devices if this is not a bootstrap and devfs
	# is used, as this was the cause for all the devfs problems we had
	if [ $altmerge -eq 0 ]
	then
		cd ${ROOT}/dev
		#These devices are also needed by many people and should be included
		echo "Making device nodes (this could take a minute or so...)"
		${ROOT}/usr/sbin/MAKEDEV generic-i386
		${ROOT}/usr/sbin/MAKEDEV sg
		${ROOT}/usr/sbin/MAKEDEV scd
		${ROOT}/usr/sbin/MAKEDEV rtc 
		${ROOT}/usr/sbin/MAKEDEV audio
		${ROOT}/usr/sbin/MAKEDEV hde
		${ROOT}/usr/sbin/MAKEDEV hdf
		${ROOT}/usr/sbin/MAKEDEV hdg
		${ROOT}/usr/sbin/MAKEDEV hdh
	fi
	#we create the /boot directory here so that /boot doesn't get deleted when a previous
	#baselayout is unmerged with /boot unmounted.
	install -d ${ROOT}/boot
	if [ ! -L ${ROOT}/boot/boot ]
	then
		ln -sf . ${ROOT}/boot/boot
	fi
	#we create this here so we don't overwrite an existing /etc/hosts during bootstrap
	if [ ! -e ${ROOT}/etc/hosts ]
	then
		cat << EOF >> ${ROOT}/etc/hosts
127.0.0.1	localhost
EOF
	fi
	if [ -L ${ROOT}/etc/mtab ]
	then
		rm -f ${ROOT}/etc/mtab
		if [ "$ROOT" = "/" ]
		then
			cp /proc/mounts ${ROOT}/etc/mtab
		else
			touch ${ROOT}/etc/mtab
		fi
	fi
	#we should only install empty files if these files don't already exist.
	local x
	for x in log/lastlog run/utmp log/wtmp
	do
		[ -e ${ROOT}/var/${x} ] || touch ${ROOT}/var/${x}
	done

	#handle the ${svcdir} that changed in location
	source ${ROOT}/etc/init.d/functions.sh
	if [ ! -d ${ROOT}/${svcdir}/started/ ] && [ -z "`use bootstrap`" ] && \
	   [ -z "`use build`" ]
	then
		mkdir -p ${ROOT}/${svcdir}
		mount -t tmpfs tmpfs ${ROOT}/${svcdir}
		if [ -d ${ROOT}/dev/shm/.init.d ]
		then
			cp -ax ${ROOT}/dev/shm/.init.d/. ${ROOT}/${svcdir}
		fi
	fi

	#reload init to fix unmounting problems of / on next reboot
	# this is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [ "$ROOT" = "/" ] && [ -z "`use bootstrap`" ] && [ -z "`use build`" ]
	then
		/sbin/init U &>/dev/null
	fi
}
