# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm-sensors/lm-sensors-2.8.3.ebuild,v 1.9 2004/10/25 18:52:54 plasmaroo Exp $

inherit flag-o-matic eutils toolchain-funcs

MY_P=${PN/-/_}-${PV}
S="${WORKDIR}/${MY_P}"
MYI2C="${WORKDIR}/i2c-headers"

DESCRIPTION="Hardware Sensors Monitoring by lm_sensors"
SRC_URI="http://www.lm-sensors.nu/archive/${MY_P}.tar.gz"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78"

SLOT="${KV}"

KEYWORDS="~amd64 -ppc -sparc x86"
IUSE=""
LICENSE="GPL-2"

DEPEND=""

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${PN}-2.8.2-sensors-detect-gentoo.diff > /dev/null || die

	# Get the right I2C includes without dropping the kernel includes
	mkdir -p ${MYI2C}/linux
	cp /usr/include/linux/i2c* ${MYI2C}/linux/
}

src_compile()  {
	echo
	einfo "*****************************************************************"
	einfo
	einfo "This ebuild assumes your /usr/src/linux kernel is the one you"
	einfo "used to build i2c-2.8.2."
	einfo
	einfo "For 2.5+ series kernels, use the support already in the kernel"
	einfo "under 'Character devices' -> 'I2C support' and then merge this"
	einfo "ebuild."
	einfo
	einfo "To cross-compile, 'export LINUX=\"/lib/modules/<version>/build\"'"
	einfo "or symlink /usr/src/linux to another kernel."
	einfo
	einfo "*****************************************************************"
	echo

	UserModeOnly=false
	if [ "$LINUX" != "" ]; then
		einfo "Cross-compiling using:- $LINUX"
		LINUX=`echo $LINUX | sed 's/build\//build/'`
		KV=`cut -d\  -f3 ${LINUX}/include/linux/version.h | grep \" | sed -e 's/"//' -e 's/"//'`
		if [ "${KV}" == "" ]; then
			die "Could not get kernel version; make sure ${LINUX}include/linux/version.h is there!"
		fi
	else
		LINUX='/usr/src/linux'
		check_KV || die "Cannot find kernel in /usr/src/linux!"
		einfo "Using kernel in /usr/src/linux/:- ${KV}"
	fi
	if [ `echo ${KV} | grep 2\.[56]\.` ]; then
		einfo "You are using a 2.5 / 2.6 series kernel; only building utilities..."
		UserModeOnly=true
	else
		einfo "You are using a `echo ${KV} | cut -d. -f-2` series kernel; building everything..."
	fi
	if [ "${KV}" != "${SLOT}" ]; then
		echo
		ewarn "WARNING:- Specified and running kernels do not match!"
		ewarn "WARNING:- This package will be slotted as ${SLOT}!"
	fi

	if [ ! -e ${MYI2C}/linux/i2c.h ]; then
		cp $LINUX/include/linux/i2c* ${MYI2C}/linux || die "No I2C Includes! Install I2C!"
	fi

	echo; einfo "You may safely ignore any errors from compilation"
	einfo "that contain 'No such file' references."

	echo
	filter-flags -fPIC -fstack-protector

	cd ${S}
	emake clean

	rm kernel/chips/via686a.d
	rm kernel/chips/vt1211.d
	if [ ${UserModeOnly} == true ]; then
		emake CC=$(tc-getCC) I2C_HEADERS=${MYI2C} user || die "Could not compile user-mode utilities!"
	else
		emake CC=$(tc-getCC) I2C_HEADERS=${MYI2C} LINUX=$LINUX || die "lm_sensors requires the source of a compatible kernel version in /usr/src/linux or specified in \$LINUX and >=i2c-2.8.1 support built as modules. Make sure that I2C >=2.8.1 is on your system before filing a bug."
	fi
}

src_install() {

	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/sbin
	if [ ${UserModeOnly} == true ]; then
		emake DESTDIR=${D} PREFIX=${D}/usr MANDIR=${D}/usr/share/man user_install || die "Install failed!"
	else
		emake LINUX=$LINUX DESTDIR=${D} PREFIX=${D}/usr MANDIR=${D}/usr/share/man install || die "Install failed!"
	fi
	cp ${D}/${D}* ${D} -Rf
	rm ${D}/var -Rf

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc lm_sensors
	dodoc BACKGROUND BUGS CHANGES CONTRIBUTORS COPYING INSTALL QUICKSTART \
		README* TODO
	cp -a doc/* ${D}/usr/share/doc/${PF}

}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	echo
	einfo
	einfo "The lm_sensors hardware sensors package has been installed."
	einfo
	einfo "It is recommended that you read the lm_sensors documentation."
	einfo "To enable lm_sensors you will need to compile i2c support in"
	einfo "your kernel as a module and run /usr/sbin/sensors-detect to"
	einfo "detect the hardware in your system."
	einfo
	einfo "Be warned, the probing of hardware in your system performed by"
	einfo "sensors-detect could freeze your system.  Also do not use"
	einfo "lm_sensors on certain laptop models from IBM.  See the lm_sensors"
	einfo "documentation and website for more information."
	einfo
	einfo "IMPORTANT: When you merge this package it installs kernel modules"
	einfo "that can only be used with the specific kernel version whose"
	einfo "source is located in /usr/src/linux.  If you upgrade to a new"
	einfo "kernel, you will need to remerge the lm_sensors package to build"
	einfo "new kernel modules."
	einfo
	echo
}
