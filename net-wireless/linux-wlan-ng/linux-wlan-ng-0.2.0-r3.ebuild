# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/linux-wlan-ng/linux-wlan-ng-0.2.0-r3.ebuild,v 1.1 2004/02/01 23:33:51 latexer Exp $

inherit eutils

IUSE="apm build nocardbus pcmcia pnp trusted usb"

PCMCIA_CS="pcmcia-cs-3.2.5"
PATCH_3_2_6="pcmcia-cs-3.2.5-3.2.6.diff.gz"
PATCH_3_2_7="pcmcia-cs-3.2.5-3.2.7.diff.gz"
PCMCIA_DIR="${WORKDIR}/${PCMCIA_CS}"

DESCRIPTION="The linux-wlan Project"
SRC_URI="ftp://ftp.linux-wlan.org/pub/linux-wlan-ng/${P}.tar.gz
		mirror://gentoo/${PN}-gentoo-init.gz
		pcmcia?	( mirror://sourceforge/pcmcia-cs/${PCMCIA_CS}.tar.gz \
			http://dev.gentoo.org/~latexer/files/patches/${PCMCIA_CS}-module-init-tools.diff.gz \
			http://dev.gentoo.org/~latexer/files/patches/${PATCH_3_2_6} \
			http://dev.gentoo.org/~latexer/files/patches/${PATCH_3_2_7} )"

HOMEPAGE="http://linux-wlan.org"
DEPEND="sys-kernel/linux-headers
		dev-libs/openssl
		sys-apps/baselayout
		>=sys-apps/sed-4.0*
		pcmcia?	( >=sys-apps/pcmcia-cs-3.2.5 )"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86"

# Note: To use this ebuild, you should have the usr/src/linux symlink to
# the kernel directory that linux-wlan-ng should use for configuration.
#
# linux-wlan-ng requires a configured pcmcia-cs source tree.
# unpack/configure it in WORKDIR.  No need to compile it though.

src_unpack() {

	unpack ${P}.tar.gz
	unpack ${PN}-gentoo-init.gz

	# install a gentoo style init script

	cp ${PN}-gentoo-init ${S}/etc/rc.wlan

	check_KV

	if [ -n "`use pcmcia`" ]; then
		if egrep '^CONFIG_PCMCIA=[ym]' /usr/src/linux/.config >&/dev/null; then
			einfo "Kernel PCMCIA is enabled. Skipping external pcmcia-cs sources."
		else
			unpack ${PCMCIA_CS}.tar.gz
			cd ${PCMCIA_DIR}
			# Fix for module-init-tools only systems
			epatch ${DISTDIR}/${PCMCIA_CS}-module-init-tools.diff.gz
			if [ -z "`has_version >=sys-apps/pcmcia-cs-3.2.7`" ]; then
				epatch ${DISTDIR}/${PATCH_3_2_7}
			elif [ -z "`has_version >=sys-apps/pcmcia-cs-3.2.6`" ]; then
				epatch ${DISTDIR}/${PATCH_3_2_6}
			fi
		fi
	fi


	# Lots of sedding to do to get the man pages and a few other
	# things to end up in the right place.

	cd ${S}
	#mv man/Makefile man/Makefile.orig
	sed -i -e "s:mkdir:#mkdir:" \
		-e "s:cp nwepgen.man:#cp nwepgen.man:" \
		-e "s:\t\$(TARGET_:\t#\$(TARGET_:" \
			man/Makefile

	#mv etc/wlan/Makefile etc/wlan/Makefile.orig
	sed -i -e "s:/etc/wlan:/etc/conf.d:g" \
		etc/wlan/Makefile

	#mv etc/wlan/wlancfg-DEFAULT etc/wlan/wlancfg-DEFAULT.orig
	sed -i -e "s:/sbin/nwepgen:/sbin/keygen:" \
		etc/wlan/wlancfg-DEFAULT

	#mv etc/wlan/shared etc/wlan/shared.orig
	sed -i -e "s:/etc/wlan/wlan.conf:/etc/conf.d/wlan.conf:g" \
	    -e "s:/etc/wlan/wlancfg:/etc/conf.d/wlancfg:g" \
		etc/wlan/shared

}

src_compile() {

	#
	# configure pcmcia-cs - we need this for wlan to compile
	# use same USE flags that the pcmcia-cs ebuild does.
	# no need to actually compile pcmcia-cs...
	# * This is actually only used if pcmcia_cs is NOT compiled into
	# the kernel tree.
	#

	local myarch kernelpcmcia

	if egrep '^CONFIG_PCMCIA=[ym]' /usr/src/linux/.config >&/dev/null; then
		kernelpcmcia="yes"
	else
		kernelpcmcia="no"
	fi

	if [ -n "`use pcmcia`" ]; then
		if [ "${kernelpcmcia}" = "no" ]; then
			# Set myarch since pcmcia-cs expects i386, not x86
			case "${ARCH}" in
				x86) myarch="i386" ;;
				*) myarch="${ARCH}" ;;
			esac

			cd ${PCMCIA_DIR}
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

			#use $CFLAGS for user tools, but standard kernel optimizations for
			#the kernel modules (for compatibility)
			./Configure -n \
				--target=${D} \
				--srctree \
				--kernel=/usr/src/linux \
				--arch="${myarch}" \
				--uflags="${CFLAGS}" \
				--kflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer" \
				$myconf || die "failed configuring pcmcia-cs"
		fi
	fi
	# now lets build wlan-ng
	cd ${S}

	#cp config.in default.config

	sed -i -e 's:TARGET_ROOT_ON_HOST=:TARGET_ROOT_ON_HOST=${D}:' \
		-e 's:PRISM2_PCI=n:PRISM2_PCI=y:' \
			config.in
	#mv default.config config.in

	if [ -n "`use pcmcia`" ]; then
		if [ "${kernelpcmcia}" = "no" ]
		then
			export PCMCIA_CS=${PCMCIA_CS}
			sed -i -e 's:PCMCIA_SRC=:PCMCIA_SRC=${WORKDIR}/${PCMCIA_CS}:' \
				config.in
		fi
		sed -i -e 's:PRISM2_PLX=n:PRISM2_PLX=y:' \
			config.in
	else
		sed -i -e 's:PRISM2_PCMCIA=y:PRISM2_PCMCIA=n:' \
			config.in
	fi
	#mv default.config config.in

	if [ -n "`use usb`" ]; then
		sed -i -e 's:PRISM2_USB=n:PRISM2_USB=y:' \
			config.in
		#mv default.config config.in
	fi

	#mv default.config config.in
	cp config.in default.config

	emake default_config || die "failed configuring WLAN"
	emake all || die "failed compiling"

	# compile add-on keygen program.  It seems to actually provide usable keys.
	cd ${S}/add-ons/keygen

	emake || die "Failed to compile add-on keygen program"
}

src_install () {

	make install || die "failed installing"

	dodir etc/wlan
	mv ${D}/etc/conf.d/shared ${D}/etc/wlan/

	if [ -z "`use build`" ]; then

		dodir /usr/share/man/man1
		newman ${S}/man/nwepgen.man nwepgen.1
		newman ${S}/man/wlancfg.man wlancfg.1
		newman ${S}/man/wlanctl-ng.man wlanctl-ng.1
		newman ${S}/man/wland.man wland.1

		dodoc CHANGES COPYING LICENSE FAQ README THANKS TODO \
		      doc/config* doc/capturefrm.txt
	fi

	exeinto /sbin
	doexe add-ons/keygen/keygen

}

pkg_postinst() {
	depmod -a

	einfo "Setup:"
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
	einfo "Be sure to add iface_wlan0 parameters to /etc/conf.d/net."
	einfo ""
	ewarn "Wireless cards which you want to use drivers other than wlan-ng for"
	ewarn "need to have the appropriate line removed from /etc/pcmcia/wlan-ng.conf"
	ewarn "Do 'cardctl info' to see the manufacturer ID and remove the corresponding"
	ewarn "line from that file."
}
