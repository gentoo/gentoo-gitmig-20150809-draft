# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs-tools/pcmcia-cs-tools-3.2.4.ebuild,v 1.2 2003/06/11 01:26:07 msterret Exp $

P=${P/-tools/}
S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="mirror://sourceforge/pcmcia-cs/${P}.tar.gz"

HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="sys-kernel/linux-headers
	>=sys-apps/sed-4
	gtk? ( =x11-libs/gtk+-1.2* )
	X? ( x11-base/xfree )"
RDEPEND=""
SLOT="0"
IUSE="trusted apm pnp nocardbus build gtk X"
LICENSE="GPL-2"
KEYWORDS="~x86"

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

	cd ${S}
	mv Configure Configure.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
	chmod ug+x Configure
	#man pages will now install into /usr/share/man
}

src_compile() {
	local myconf
	use trusted && myconf="--trust" || myconf="--notrust"
	use apm && myconf="$myconf --apm" || myconf="$myconf --noapm"
	use pnp && myconf="$myconf --pnp" || myconf="$myconf --nopnp"
	use nocardbus &&  myconf="$myconf --nocardbus" || myconf="$myconf --cardbus"

	#use $CFLAGS for user tools, but standard kernel optimizations for the kernel modules (for compatibility)
	./Configure -n \
		--force \
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

	# The --srctree option tells pcmcia-cs to configure for the kernel in
	# /usr/src/linux rather than the currently-running kernel.  It's Gentoo
	# Linux policy to configure for the kernel in /usr/src/linux

	# This handles the various cardinfo guis.  If you have gtk in your USE,
	# then the gtk version will be installed.  If not, but X is in your USE,
	# then the xaw version will be installed.  Otherwise, no gui will be
	# installed.
	sed -e "/^HAS_FORMS/d" config.out > config.out.1
	sed -e "/^HAS_FORMS/d" config.mk > config.mk.1
	if [ -z `use gtk` ] || [  -n `use build` ]; then
		sed -i -e "/^HAS_GTK/d" config.out.1
		sed -i -e "/^HAS_GTK/d" config.mk.1
		if [ -z `use X` ] || [ -n `use build` ]; then
			sed -i -e "/^HAS_XAW/d" config.out.1
			sed -i -e "/^HAS_XAW/d" config.mk.1
		fi
	fi
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.out.1 > config.out
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.mk.1 > config.mk
	rm -f config.out.1
	rm -f config.mk.1

	cd ${S}/cardmgr
	emake all || die "failed compiling"
	cd ${S}/flash
	emake all || die "failed compiling"
}

src_install () {
	cd ${S}/cardmgr
	make PREFIX=${D} install || die "failed installing"
	cd ${S}/flash
	make PREFIX=${D} install || die "failed installing"
	cd ${S}/etc
	make PREFIX=${D} install || die "failed installing"
	cd ${S}/man
	make PREFIX=${D} install-man1-x11 install-man5 install-man8

	rm -rf ${D}/etc/rc*.d

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

