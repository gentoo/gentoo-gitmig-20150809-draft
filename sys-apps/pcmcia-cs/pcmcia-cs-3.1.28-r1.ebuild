# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.1.28-r1.ebuild,v 1.2 2001/09/02 19:58:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="http://prdownloads.sourceforge.net/pcmcia-cs/${P}.tar.gz"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="sys-devel/gcc X? ( virtual/x11 x11-libs/xforms )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Configure Configue.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
}

src_compile() {
	./Configure -n --target=${D} --cardbus --pnp --apm --target=${D} || die "failed configuring"
	emake all || die "failed compiling"
}

src_install () {
	make install || die "failed installing"
	cd ${D}
	touch var/lib/pcmcia/.keep
	# remove things it installed but we don't want:
	# remove non-gentoo-conforming init scripts, we have our own 
	rm etc/rc.d/rc.pcmcia
	# remove kernel modules, we have our own kernel ebuild tangle
	# rm -rf lib
	# remove X util if USE X isn't set
	# this is simply much easier than patching configure or the makefiles
	# not to build them in the first place
	use X || rm -rf usr/X11R6
		
	# install our own init script
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

