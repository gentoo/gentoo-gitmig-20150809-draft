# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Craig Joly <joly@ee.ualberta.ca>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.1.29.ebuild,v 1.1 2001/08/29 23:35:49 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="http://prdownloads.sourceforge.net/pcmcia-cs/${P}.tar.gz"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="~sys-kernel/linux-headers-2.4.8.8 sys-devel/gcc X? ( virtual/x11 x11-libs/xforms )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Configure Configure.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
	#man pages will now install into /usr/share/man
}

src_compile() {
	#use $CFLAGS for user tools, but standard kernel optimizations for the kernel modules (for compatibility)
	./Configure -n --kernel=/usr/src/linux-2.4.8-ac8 --force --arch="$CHOST" --uflags="$CFLAGS" --kflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer" --cardbus --pnp --apm || die "failed configuring"
	emake all || die "failed compiling"
}

src_install () {
	make PREFIX=${D} install || die "failed installing"
	cd ${D}
	#this will cause the /var/lib/pcmcia to not be auto-removed when you remerge 
	#pcmcia-cs; this can migrate to baselayout eventually
	touch var/lib/pcmcia/.keep
	#remove non-gentoo-conforming init scripts, we have our own 
	rm etc/rc.d/rc.pcmcia
	#remove X util if USE X isn't set
	#this is simply much easier than patching configure or the makefiles
	#not to build them in the first place
	use X || rm -rf usr/X11R6
		
	#install our own init script
	exeinto /etc/init.d
	#newins ${FILESDIR}/pcmcia.settings pcmcia
	newexe ${FILESDIR}/pcmcia.new pcmcia
	if [ -z "`use build`" ]
	then
		cd ${S}
		# install docs
		dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README README-2.4 SUPPORTED.CARDS doc/*
	else
		rm -rf ${D}/usr/share/man
	fi
}

