#Copyright 1999 Daniel Robbins
#Distributed under the GPL

P=00initscripts-1.0      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Colorized initscripts for Enoch"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/"${A}

src_install() {                               
	for x in boot halt 1 2 3 4 5 
	do
	    dodir /etc/rc.d/rc${x}.d
	done
        dosym rcboot.d /etc/rc.d/rc0.d
        dosym rchalt.d /etc/rc.d/rc6.d

	dodir /etc/rc.d/init.d
	dodir /etc/rc.d/config
	cd etc/rc.d/init.d
	insinto /etc/rc.d/init.d
	doins *
	chmod 0755 ${D}/etc/rc.d/init.d/*
	insinto /etc/rc.d/init.d/extra_scripts
	cd ${S}/etc/rc.d/config
	insinto /etc/rc.d/config
        doins *
	doins runlevels
	cd ${S}
	insinto /etc
	doins etc/inittab
	into /usr
	dosbin sbin/rc-update
	exeinto /usr/bin
	exeopts -m0755
	doexe usr/bin/colors
	dodoc usr/doc/initscripts/*
}


