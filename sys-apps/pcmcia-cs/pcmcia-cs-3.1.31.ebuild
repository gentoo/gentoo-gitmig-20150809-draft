# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Craig Joly <joly@ee.ualberta.ca>, Daniel Robbins <drobbins@gentoo.org>, Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.1.31.ebuild,v 1.1 2002/01/20 21:40:05 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="http://prdownloads.sourceforge.net/pcmcia-cs/${P}.tar.gz"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="sys-kernel/linux-headers X? ( virtual/x11 x11-libs/xforms )"
RDEPEND="X? ( virtual/x11 x11-libs/xforms )"

# Note: To use this ebuild, you should have the usr/src/linux symlink to 
# the kernel directory that pcmcia-cs should use for configuration.

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Configure Configure.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
	#man pages will now install into /usr/share/man
}

src_compile() {
	#use $CFLAGS for user tools, but standard kernel optimizations for the kernel modules (for compatibility)
	./Configure -n \
		--kernel=/usr/src/linux \
		--force \
		--arch="i386" \
		--uflags="$CFLAGS" \
		--kflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer" \
		--cardbus \
		--nopnp \
		--noapm || die "failed configuring"
	# nopnp and noapm are important, because without them the pcmcia-cs 
	# tools will require a kernel with ISA PnP and/or APM support, 
	# which cannot be guaranteed.  We need to make sure the tools 
	# work *all* the time, not just some of the time.
	emake all || die "failed compiling"
}

src_install () {
	make PREFIX=${D} install || die "failed installing"
	cd ${D}
	rm -rf etc/rc*.d
	# this will cause the /var/lib/pcmcia to not be auto-removed 
	# when you remerge pcmcia-cs; this can migrate to baselayout
	# eventually
	touch var/lib/pcmcia/.keep
	# remove non-gentoo-conforming init scripts, we have our own 
	rm etc/rc.d/rc.pcmcia
	# remove X util if USE X isn't set
	# this is simply much easier than patching configure or the makefiles
	# not to build them in the first place
	use X || rm -rf usr/X11R6
	# todo: if they are nstalled, move them to /usr
		
	# install our own init script
	exeinto /etc/init.d
	#newins ${FILESDIR}/pcmcia.settings pcmcia
	newexe ${FILESDIR}/pcmcia.new pcmcia
	if [ -z "`use build`" ]
	then
		cd ${S}
		# install docs
		dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README \
			README-2.4 SUPPORTED.CARDS doc/*
	else
		rm -rf ${D}/usr/share/man
	fi
	rm ${D}/etc/modules.conf

}

src_postinst() {
	einfo "To avail yourself of the pcmcia-cs drivers, you have to disable the PCMCIA support in the kernel."
	einfo "(Otherwise, you might experience CardServices version mismatch errors)"
}
