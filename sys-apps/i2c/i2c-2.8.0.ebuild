# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c/i2c-2.8.0.ebuild,v 1.10 2003/12/26 10:17:41 plasmaroo Exp $

DESCRIPTION="I2C Bus support for 2.4.x kernels"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78/"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="x86 ~alpha ~amd64 ~ppc"

DEPEND=""

pkg_setup() {
	echo
	einfo "*****************************************************************"
	einfo
	einfo "This ebuild assumes your *current* kernel is >=2.4.9 && < 2.5+ "
	einfo
	einfo "For 2.5+ series kernels, use the support already in the kernel"
	einfo "under 'Character devices' -> 'I2C support'."
	einfo
	einfo "To cross-compile, 'export LINUX=\"/lib/modules/<version>/build\"'"
	einfo "or symlink /usr/src/linux to another kernel."
	einfo
	einfo "*****************************************************************"
	echo

	eerror "*****************************************************************"
	eerror
	eerror "WARNING: This i2c support is not recommended for things such as "
	eerror "WARNING: BTTV"
	eerror
	eerror "*****************************************************************"
	eerror
	eerror "http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/README"
	eerror
	eerror "35 ADDITIONALLY, i2c-2.8.0 is not API compatible to earlier i2c"
	eerror "36 releases due to struct changes; therefore you must NOT ENABLE"
	eerror "37 any other i2c drivers (e.g. bttv) in the kernel."
	eerror "38 Do NOT use lm-sensors 2.8.0 or i2c-2.8.0 if you require bttv."
	eerror
	eerror "Please try out http://www.ensicaen.ismra.fr/~delvare/devel/i2c/"
	eerror "for a kernel patch which will fix this problem. Please note that"
	eerror "nor the lm_sensors team nor the package maintainers will be able"
	eerror "to support you if you encounter problems with I2C when using"
	eerror "other modules with requirements on I2C..."
	eerror
	eerror "*****************************************************************"
	echo
}

src_compile ()  {
	echo
	if [ "$LINUX" != "" ]; then
		echo -n ' '; einfo "Cross-compiling using:- $LINUX"
		echo -n ' '; einfo "Using headers from:- `echo $LINUX/include/linux | sed 's/\/\//\//'`"
		LINUX=`echo $LINUX | sed 's/build\//build/'`
	else
		echo -n ' '; einfo "You are running:- `uname -r`"
		check_KV || die "Cannot find kernel in /usr/src/linux"
		echo -n ' '; einfo "Using kernel in /usr/src/linux:- ${KV}"

		echo ${KV} | grep 2.4. > /dev/null
		if [ $? == 1 ]; then
			echo -n ' '; eerror "Kernel version in /usr/src/linux is not 2.4.x"
			echo -n ' '; eerror "Please specify a 2.4.x kernel!"
			die "Incompatible Kernel"
		else
			LINUX='/usr/src/linux'
		fi

		if [ "${KV}" != "`uname -r`" ]; then
			echo -n ' '; ewarn "WARNING:- kernels do not match!"
		fi
	fi

	cd kernel;
	epatch ${FILESDIR}/i2c-2.8.0-alphaCompile.patch > /dev/null;
	cd ..;

	echo; echo -n ' '; einfo "You may safely ignore any errors from compilation"
	echo -n ' '; einfo "that contain 'No such file' references."
	echo; echo '>>> Compiling...'

	emake LINUX=$LINUX clean all
	if [ $? != 0 ]; then
		eerror "I2C requires the source of a compatible kernel"
		eerror "version installed in /usr/src/linux"
		eerror "(or the environmental variable \$LINUX)"
		eerror "and kernel I2C *disabled* or *enabled as a module*"
		die "Error: compilation failed!"
	fi

}

src_install() {
	emake \
		LINUX=$LINUX \
		LINUX_INCLUDE_DIR=/usr/include/linux \
		DESTDIR=${D} \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		install || die
	dodoc CHANGES INSTALL README
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	einfo
	einfo "I2C modules installed ..."
	einfo
	ewarn "IMPORTANT ... if you are installing this package you need to"
	ewarn "IMPORTANT ... *disable* kernel I2C support OR *modularize it*"
	ewarn "IMPORTANT ... if your 2.4.x kernel is patched with such support"
	einfo
	echo
}
