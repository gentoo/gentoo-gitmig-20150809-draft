# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs-drivers/pcmcia-cs-drivers-3.2.4.ebuild,v 1.2 2003/06/11 01:41:21 msterret Exp $

inherit eutils

P=${P/-drivers/}
S=${WORKDIR}/${P}
DESCRIPTION="pcmcia-cs drivers"
SRC_URI="mirror://sourceforge/pcmcia-cs/${P}.tar.gz
	http://airsnort.shmoo.com/${P}-orinoco-patch.diff"

HOMEPAGE="http://pcmcia-cs.sourceforge.net"
DEPEND="sys-kernel/linux-headers
	>=sys-apps/sed-4"
RDEPEND=""
SLOT="0"
IUSE="trusted apm pnp nocardbus build"
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
	epatch ${DISTDIR}/${P}-orinoco-patch.diff

	cd ${S}
	mv Configure Configure.orig
	sed -e 's:usr/man:usr/share/man:g' Configure.orig > Configure
	chmod ug+x Configure
	#man pages will now install into /usr/share/man

	einfo `use gtk`
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
	sed -i -e "/^HAS_GTK/d" config.out.1
	sed -i -e "/^HAS_GTK/d" config.mk.1
	sed -i -e "/^HAS_XAW/d" config.out.1
	sed -i -e "/^HAS_XAW/d" config.mk.1
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.out.1 > config.out
	sed -e "s/^FLIBS=\".*\"/FLIBS=\"\"/" config.mk.1 > config.mk
	rm -f config.out.1
	rm -f config.mk.1


	# patch version.h so that they won't complain that Card Services is wrong.
	if [ -n "`grep -E '^CONFIG_PCMCIA\=y' config.mk`" ]; then
		cd ${S}/include/pcmcia

		# get kernel CS_RELEASE :
		if [ -f /usr/src/linux/include/pcmcia/version.h ]; then
			KERNEL_RELEASE=`grep -E '^#define CS_RELEASE ' /usr/src/linux/include/pcmcia/version.h | awk '{print $3}'`
			KERNEL_RELEASE_CODE=`grep -E '^#define CS_RELEASE_CODE ' /usr/src/linux/include/pcmcia/version.h | awk '{print $3}'`
		else
			die "unable to find /usr/src/linux/include/pcmcia/version.h"
		fi

		# replace CS_PKG_RELEASE :
		if [ -f version.h ]; then
			sed "s|\(#define CS_PKG_RELEASE.*\)\".*\"|\1$KERNEL_RELEASE|" version.h  > version.h.new
			sed "s|\(#define CS_PKG_RELEASE_CODE.*\)0x.*|\1$KERNEL_RELEASE_CODE|" version.h.new > version.h
		fi

		cd ${S}/clients
		emake all || die "failed compiling"
		cd ${S}/wireless
		emake all || die "failed compiling"
	else
		eerror "Please enable PCMCIA in your kernel in /usr/src/linux"
		eend
	fi

}

src_install () {
	cd ${S}/clients
	make PREFIX=${D} install || die "failed installing"
	cd ${S}/wireless
	make PREFIX=${D} install || die "failed installing"
	cd ${S}/man
	make PREFIX=${D} install-man4 || die "failed installing"

	rm -f ${D}/etc/modules.conf
	rm -rf ${D}/var/lib/pcmcia
}

pkg_postinst() {
	einfo "Please note that some of these drivers are also provided by the kernel.  To use a driver installed"
	einfo "by this ebuild, you must *disable* the corresponding driver in the kernel."
}
