# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.7.0_pre2.ebuild,v 1.8 2003/12/29 19:01:29 lanius Exp $

inherit eutils kernel-mod

DESCRIPTION="LIRC is a package that allows you to decode and send infra-red \
	signals of many (but not all) commonly used remote controls."
HOMEPAGE="http://www.lirc.org"

[ "x${LIRC_OPTS}" = x ] && LIRC_OPTS="--with-driver=serial \
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
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/linux-sources"

MY_P=${P/_/}

SRC_URI="http://lirc.sourceforge.net/software/snapshots/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed	-i "s:-O2 -g:${CFLAGS}:" configure
	sed -i "s:-O2 -g:${CFLAGS}:" configure.in
}

src_compile() {
	ewarn "If you are using a 2.6 kernel you have to patch it for lirc support."
	ewarn "There are several patches floating around, one of them can be found at "
	ewarn "http://lwn.net/Articles/42217/."

	ewarn "make sure you have IrDA (infrared) support"
	ewarn "in your kernel or this will fail"

	# Let portage tell us where to put our modules
	check_KV

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-kerneldir="/usr/src/linux" \
		--with-moduledir="/lib/modules/${KV}/misc" \
		--disable-manage-devices \
		--enable-sandboxed \
		${LIRC_OPTS} || die "./configure failed"

	if kernel-mod_is_2_6_kernel; then
		(cd daemons; emake) || die
		(cd tools; emake) || die
		(cd doc; emake) || die
	else
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
	fi
}

src_install() {
	if kernel-mod_is_2_6_kernel; then
		(cd daemons; make DESTDIR=${D} install) || die
		(cd tools; make DESTDIR=${D} install) || die
		(cd doc; make DESTDIR=${D} install) || die
	else
		emake || die
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
	fi

	exeinto /etc/init.d
	doexe ${FILESDIR}/lircd

	dohtml doc/html/*.html
}

pkg_postinst () {
	if kernel-mod_is_2_4_kernel; then
		/usr/sbin/update-modules
	fi

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
