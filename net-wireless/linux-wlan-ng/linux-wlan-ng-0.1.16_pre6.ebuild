# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/linux-wlan-ng/linux-wlan-ng-0.1.16_pre6.ebuild,v 1.7 2003/09/10 04:47:55 msterret Exp $

# linux-wlan-ng requires a configured pcmcia-cs source tree.
# unpack/configure it in WORKDIR.  No need to compile it though.

IUSE="trusted apm pnp nocardbus pcmcia build"
PCMCIA_CS="pcmcia-cs-3.2.1"
PCMCIA_DIR="${WORKDIR}/${PCMCIA_CS}"

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The linux-wlan Project"
SRC_URI="ftp://ftp.linux-wlan.org/pub/linux-wlan-ng/${MY_P}.tar.gz
		pcmcia?	( mirror://sourceforge/pcmcia-cs/${PCMCIA_CS}.tar.gz )"

HOMEPAGE="http://linux-wlan.org"
DEPEND="sys-kernel/linux-headers
		dev-libs/openssl
		sys-apps/baselayout
		pcmcia?	( sys-apps/pcmcia-cs )"
RDEPEND=""
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86"

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
#* This is actually only used if pcmcia_cs is NOT compiled into the kernel tree.
	if [ -n "`use pcmcia`" ]; then
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
	fi
	# now lets build wlan-ng
	cd ${S}
	if [ -n "`use pcmcia`" ]; then
		export PCMCIA_CS=${PCMCIA_CS}; sed -e 's:PCMCIA_SRC=:PCMCIA_SRC=${WORKDIR}/${PCMCIA_CS}:' \
			-e 's:PRISM2_PLX=n:PRISM2_PLX=y:' \
			config.in > default.config
	else
		sed -e 's:PRISM2_PCMCIA=y:PRISM2_PCMCIA=n:' \
		config.in > default.config
	fi
	mv default.config config.in

	sed -e 's:TARGET_ROOT_ON_HOST=:TARGET_ROOT_ON_HOST=${D}:' \
		-e 's:PRISM2_USB=n:PRISM2_USB=y:' \
		-e 's:PRISM2_PCI=n:PRISM2_PCI=y:' \
		config.in > default.config

	emake default_config || die "failed configuring WLAN"
	emake all || die "failed compiling"

	#compile add-on keygen program.  It seems to actually provide usable keys.
	cd ${S}/add-ons/keygen

	emake || die "Failed to compile add-on keygen program"
}

src_install () {
	# einfo PREFIX=${D}
	make install || die "failed installing"
	cd ${D}

	mkdir etc/conf.d
	mv etc/wlan/wlan.conf etc/conf.d

	mv etc/wlan/wlancfg-DEFAULT wlancfg-DEFAULT.orig
	sed -e 's:/sbin/nwepgen:/sbin/keygen:' wlancfg-DEFAULT.orig >etc/conf.d/wlancfg-DEFAULT
	rm -f wlancfg-DEFAULT.orig

	mv etc/wlan/shared shared.orig
	sed -e 's:/etc/wlan/wlan.conf:/etc/conf.d/wlan.conf:g' \
	    -e 's:/etc/wlan/wlancfg:/etc/conf.d/wlancfg:g' shared.orig >etc/wlan/shared
	rm -f shared.orig

	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc CHANGES COPYING LICENSE FAQ README THANKS TODO \
		      doc/config* doc/capturefrm.txt doc/wireless-extensions/README.wireless-extensions
	fi
	exeinto /sbin
	doexe add-ons/keygen/keygen

}

pkg_postinst() {
	depmod -a

	einfo "Configuration of the WLAN package has changed since 0.1.16-pre4."
	einfo ""
	einfo "/etc/init.d/wlan is used to control startup and shutdown of non-PCMCIA devices."
	einfo "/etc/init.d/pcmcia from pcmcia-cs is used to control startup and shutdown of"
	einfo "PCMCIA devices."
	einfo ""
	einfo "The wlan-ng.opts file in /etc/pcmcia/ is now depricated."
	einfo ""
	einfo "Modify /etc/conf.d/wlan.conf to set global parameters."
	einfo "Modify /etc/conf.d/wlancfg-* to set individual card parameters."
	einfo "There are detailed instructions in these config files."
	einfo ""
	einfo "Two keygen programs are included: nwepgen and keygen.  keygen seems"
	einfo "provide more usable keys at the moment."
	einfo ""
	einfo "Be sure to add iface_wlan0 parameters to /etc/conf.d/net."
	einfo ""
	ewarn "Wireless cards which you want to use drivers other than wlan-ng for"
	ewarn "need to have the appropriate line removed from /etc/pcmcia/wlan-ng.conf"
	ewarn "Do 'cardctl info' to see the manufacturer ID and remove the corresponding"
	ewarn "line from that file."
}


