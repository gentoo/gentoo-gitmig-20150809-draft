# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.2.1-r2.ebuild,v 1.5 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="mirror://sourceforge/pcmcia-cs/${P}.tar.gz
	http://airsnort.shmoo.com/pcmcia-cs-3.2.1-orinoco-patch.diff
	http://ozlabs.org/people/dgibson/dldwd/orinoco-0.12b.tar.gz"

HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="sys-kernel/linux-headers"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

# check arch for configure
if [ ${ARCH} = "x86" ] ; then
	MY_ARCH="i386"
else
	MY_ARCH="ppc"
fi

# Note: To use this ebuild, you should have the usr/src/linux symlink to 
# the kernel directory that pcmcia-cs should use for configuration.

src_unpack() {
	unpack ${P}.tar.gz

	# apply the patch for airsnort
	ln -s ${P} ${P}-patched
	pushd ${P}
	patch -p0 < ${DISTDIR}/${P}-orinoco-patch.diff
	popd

	if [ -z "`use wavelan`" ] ; then

	unpack orinoco-0.12b.tar.gz
	cd ${S}
	mv ../orinoco-0.12b/hermes*.{c,h} \
		../orinoco-0.12b/orinoco*.{c,h} \
		../orinoco-0.12b/ieee802_11.h wireless/

	fi
	
	cd ${S}
	cp Configure Configure.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
	#man pages will now install into /usr/share/man

	cd ${S}
	### As per the SourceForge web site reqs and bug #3400
	# We'll replace all ide_cs with ide-cs
	cp etc/config etc/config.orig
	sed -e 's:ide_cs:ide-cs:g' etc/config.orig > etc/config
	rm -f etc/config.orig


}

src_compile() {
	local myconf
	if [ -n "`use trusted`" ] ; then
		myconf="--trust"
	else
		myconf="--notrust"
	fi

	if [ -n "`use apm`" ] ; then
		myconf="$myconf --apm"
	else
		myconf="$myconf --noapm"
	fi

	if [ -n "`use pnp`" ] ; then
		myconf="$myconf --pnp"
	else
		myconf="$myconf --nopnp"
	fi
	
	if [ -n "`use nocardbus`" ] ; then
		myconf="$myconf --nocardbus"
	else
		myconf="$myconf --cardbus"
	fi

	#use $CFLAGS for user tools, but standard kernel optimizations for the kernel modules (for compatibility)
	./Configure -n \
		--target=${D} \
		--srctree \
		--kernel=/usr/src/linux \
		--arch="${MY_ARCH}" \
		--uflags="$CFLAGS" \
		--kflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer" \
		$myconf || die "failed configuring"
	# nopnp and noapm are important, because without them the pcmcia-cs 
	# tools will require a kernel with ISA PnP and/or APM support, 
	# which cannot be guaranteed.  We need to make sure the tools 
	# work *all* the time, not just some of the time.
	
	# The --srctree option tells pcmcia-cs to configure for the kernel in /usr/src/linux
	# rather than the currently-running kernel.  It's Gentoo Linux policy to configure for
	# the kernel in /usr/src/linux

	sed -e "/^HAS_FORMS/d" config.out > config.out.sed
	sed -e "/^HAS_FORMS/d" config.mk > config.mk.sed
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.out.sed > config.out
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.mk.sed > config.mk
	rm -f config.out.sed
	rm -f config.mk.sed

	emake all || die "failed compiling"
}

src_install () {
	make PREFIX=${D} install || die "failed installing"
	cd ${D}
	rm -rf etc/rc*.d
	# remove X
	# this is simply much easier than patching configure or the makefiles
	# not to build them in the first place
	rm -rf usr/X11R6
	# todo: if they are nstalled, move them to /usr
		
	insinto /etc/conf.d
	newins ${FILESDIR}/pcmcia.conf pcmcia

	exeinto /etc/pcmcia
	doexe ${FILESDIR}/network

	# install our own init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/pcmcia.rc pcmcia
	if [ -z "`use build`" ]
	then
		cd ${S}
		# install docs
		dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README \
			README-2.4 SUPPORTED.CARDS doc/*
	else
		rm -rf ${D}/usr/share/man
	fi
	rm -f ${D}/etc/modules.conf
	rm -rf ${D}/var/lib/pcmcia

	# if on ppc set the ppc revised config.opts
	if [ ${ARCH} = "ppc" ] ; then
		insinto /etc/pcmcia
		newins ${FILESDIR}/ppc.config.opts config.opts
	fi
}

pkg_postinst() {
	einfo "To avail yourself of the pcmcia-cs drivers, you have to disable the PCMCIA support in the kernel."
	einfo "(Otherwise, you might experience CardServices version mismatch errors)"
	einfo ""
	einfo "Proper kernel config for this package is that PCMCIA/CardBus under General Setup is off and"
	einfo "Wireless LAN (non-ham radio) is on but no modules or drivers turned on under Network Device Support"
	einfo "if you have wireless."
	einfo ""
	einfo "If you *don't* want to use Orinoco drivers or if they don't work for you, add +wavelan to USE"
}
