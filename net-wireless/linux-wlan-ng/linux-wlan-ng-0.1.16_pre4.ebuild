# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/linux-wlan-ng/linux-wlan-ng-0.1.16_pre4.ebuild,v 1.7 2003/09/10 04:47:55 msterret Exp $

# linux-wlan-ng requires a configured pcmcia-cs source tree.
# unpack/configure it in WORKDIR.  No need to compile it though.

IUSE="trusted apm pnp nocardbus build"

PCMCIA_CS="pcmcia-cs-3.2.1"
PCMCIA_DIR="${WORKDIR}/${PCMCIA_CS}"

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The linux-wlan Project"
SRC_URI="ftp://ftp.linux-wlan.org/pub/linux-wlan-ng/${MY_P}.tar.gz
			mirror://sourceforge/pcmcia-cs/${PCMCIA_CS}.tar.gz"

HOMEPAGE="http://linux-wlan.org"
DEPEND="sys-kernel/linux-headers
		sys-apps/pcmcia-cs
		dev-libs/openssl
		sys-apps/baselayout"
RDEPEND=""
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86"

# check arch for configure
if [ ${ARCH} = "x86" ] ; then
	MY_ARCH="i386"
else
	MY_ARCH="ppc"
fi

# Note: To use this ebuild, you should have the usr/src/linux symlink to
# the kernel directory that linux-wlan-ng should use for configuration.

src_unpack() {
	if [ -n "`use pcmcia`" ]; then
		check_KV
	fi
	unpack ${A}
}

src_compile() {

#configure pcmcia-cs - we need this for wlan to compile
#use same USE flags that the pcmcia-cs ebuild does.
#no need to actually compile pcmcia-cs...

	cd ${WORKDIR}/${PCMCIA_CS}
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
		$myconf || die "failed configuring pcmcia-cs"

	# now lets build wlan-ng
	cd ${S}
	export PCMCIA_CS=${PCMCIA_CS}; sed -e 's:PCMCIA_SRC=:PCMCIA_SRC=${WORKDIR}/${PCMCIA_CS}:' config.in > default.config1
	sed -e 's:TARGET_ROOT_ON_HOST=:TARGET_ROOT_ON_HOST=${D}:' default.config1 > default.config2
	sed -e 's:PRISM2_USB=n:PRISM2_USB=y:' default.config2 > default.config3
	sed -e 's:PRISM2_PCI=n:PRISM2_PCI=y:' default.config3 > default.config4
	sed -e 's:PRISM2_PLX=n:PRISM2_PLX=y:' default.config4 > default.config
	rm -f default.config1 default.config2 default.config3 default.config4
	emake default_config || die "failed configuring WLAN"
	emake all || die "failed compiling"

	#compile add-on keygen program.  It seems to actually provide usable keys.
	cd ${S}/add-ons/keygen

	emake || die  "Failed to compile add-on keygen program"
}

src_install () {
einfo PREFIX=${D}
	make install || die "failed installing"
	cd ${D}

	#move the conf file to conf.d
	insinto /etc/conf.d
	sed -e 's:/sbin/nwepgen:/sbin/keygen:' etc/wlan.conf >etc/conf.d/wlan.conf
	rm -f etc/wlan.conf

	mv etc/pcmcia/wlan-ng.opts wlan-ng.opts.orig
	sed -e 's:/sbin/nwepgen:/sbin/keygen:' wlan-ng.opts.orig >etc/pcmcia/wlan-ng.opts

	mv etc/init.d/wlan wlan.orig
	sed -e 's:/etc/wlan.conf:/etc/conf.d/wlan.conf:g' wlan.orig >etc/init.d/wlan
	rm -f wlan.orig wlan-ng.opts.orig
	chmod 755 etc/init.d/wlan
	chmod 640 etc/conf.d/wlan.conf etc/pcmcia/wlan-ng.opts

	# use net.eth0 style rc.init script for wlan too.
	cp /etc/init.d/net.eth0 etc/init.d/net.wlan0

	if [ -z "`use build`" ]
	then
		cd ${S}
		# install docs
		dodoc BUGS CHANGES COPYING LICENSE FAQ MAINTAINERS README \
			THANKS TODO doc/*
	fi
	exeinto /sbin
	doexe add-ons/keygen/keygen

}

pkg_postinst() {
	depmod -a

	einfo "Modify /etc/conf.d/wlan if you choose to use /etc/init.d/wlan to"
	einfo "start up your card.  This won't offer dhcp options, however."
	einfo ""
	einfo "Modify /etc/pcmcia/wlan-ng.opts to use the pcmcia card services"
	einfo "to autoload the prism2 drivers when a pccard is inserted."
	einfo "Two keygen programs are include: nwepgen and keygen.  keygen seems"
	einfo "provide more usable keys at the moment."
	einfo ""
	einfo "You will need to add iface_wlan0 parameters to /etc/conf.d/net to use the"
	einfo "pcmcia card services to load the wlan device and attach it to the network."
	einfo ""
	ewarn "Wireless cards which you want to use drivers other than wlan-ng for"
	ewarn "need to have the appropriate line removed from /etc/pcmcia/wlan-ng.conf"
	ewarn "Do 'cardctl info' to see the manufacturer ID and remove the corresponding"
	ewarn "line from that file."
}

