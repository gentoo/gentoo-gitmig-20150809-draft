# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.6.6-r1.ebuild,v 1.7 2004/01/14 16:40:46 iggy Exp $

inherit eutils

DESCRIPTION="LIRC is a package that allows you to decode and send infra-red \
	signals of many (but not all) commonly used remote controls."
HOMEPAGE="http://www.lirc.org"

[ "x${LIRC_OPTS}" = x ] && LIRC_OPTS="--with-driver=any \
	--with-port=0x3f8 --with-irq=4"

# We have a SMP enabled kernel?
if [ ! -z "`uname -v | grep SMP`" ]
then
	export SMP=1
else
	export SMP=0
fi

# This are the defaults. With this support for all supported remotes
# will be build.
# If you want other options then set the Environment variable to your needs.

# Note: If you don't specify the driver configure becomes interactiv.

# You have to know, which driver you want;
# --with-driver=X

# where X is one of:
# none, any, animax, avermedia, avermedia98,
# bestbuy, bestbuy2, caraca, chronos, comX,
# cph03x, cph06x, creative, fly98, flyvideo,
# hauppauge,hauppauge_dvb, ipaq, irdeo,
# irdeo_remote, irman, irreal, it87, knc_one,
# logitech, lptX, mediafocusI, packard_bell,
# parallel, pctv, pixelview_bt878,
# pixelview_pak, pixelview_pro, provideo,
# realmagic, remotemaster, serial, silitek,
# sir, slinke, tekram, winfast_tv2000

# This could be usefull too

# --with-port=port	# port number for the lirc device.
# --with-irq=irq	# irq line for the lirc device.
# --with-timer=value	# timer value for the parallel driver
# --with-tty=file	# tty to use (Irman, RemoteMaster, etc.)
# --without-soft-carrier	# if your serial hw generates carrier
# --with-transmitter	# if you use a transmitter diode

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc"

DEPEND="virtual/linux-sources"

SRC_URI="mirror://sourceforge/lirc/${P}.tar.bz2"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff.bz2 || die
	cp configure configure.orig
	sed \
		-e "s:-O2 -g:${CFLAGS}:" \
		< configure.orig > configure
	cp configure.in configure.in.orig
	sed \
		-e "s:-O2 -g:${CFLAGS}:" \
		< configure.in.orig > configure.in
}


src_compile() {

	#Let portage tell us where to put our modules
	check_KV

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-kerneldir="/usr/src/linux" \
		--with-moduledir="/lib/modules/${KV}/misc" \
		--disable-manage-devices \
		${LIRC_OPTS} || die "./configure failed"

	emake || die

	case ${LIRC_OPTS}
	in
	  *"any"*)
		if [ "${SMP}" = 1 ]; then
			# The parallel driver will not work with SMP kernels
			# so we need to compile without it
			emake -C drivers "SUBDIRS=lirc_dev lirc_serial \
			lirc_sir lirc_it87 lirc_i2c lirc_gpio" || die
		else
			emake -C drivers "SUBDIRS=lirc_dev lirc_serial \
			lirc_parallel lirc_sir lirc_it87 lirc_i2c \
			lirc_gpio" || die
		fi
	;;
	esac
}

src_install() {
	make DESTDIR=${D} install || die

	case ${LIRC_OPTS}
	in
	  *"any"*)
		insinto /lib/modules/${KV}/misc
		if [ "${SMP}" = 1 ]; then
			for i in lirc_dev lirc_serial \
				lirc_sir lirc_it87 lirc_i2c lirc_gpio
			do
			doins drivers/${i}/${i}.o
			done
		else
			for i in lirc_dev lirc_serial \
				lirc_parallel lirc_sir lirc_it87 lirc_i2c lirc_gpio
			do
			doins drivers/${i}/${i}.o
			done
		fi
	;;
	esac

	exeinto /etc/init.d
	doexe ${FILESDIR}/lircd
}

pkg_postinst () {
	/usr/sbin/update-modules

	einfo
	einfo "The lirc Linux Infrared Remote Control Package has been"
	einfo "merged, please read the documentation, and if necessary"
	einfo "add what is needed to /etc/modules.autoload or"
	einfo "/etc/modules.d.  If you need special compile options"
	einfo "then read the comments at the begin of this"
	einfo "ebuild (source) and set the LIRC_OPTS environment"
	einfo "variable to your needs."
	einfo
}

