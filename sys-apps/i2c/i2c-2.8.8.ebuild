# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c/i2c-2.8.8.ebuild,v 1.3 2004/11/11 23:03:43 dsd Exp $

inherit eutils toolchain-funcs

DESCRIPTION="I2C Bus support for 2.4.x kernels"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78/"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

pkg_setup() {
	echo
	eerror "WARNING: This i2c support is not recommended for things such as "
	eerror "WARNING: BTTV"
	echo
	eerror "http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/README"
	echo
	eerror "40 ADDITIONALLY, i2c-2.8.8 is not API compatible to earlier i2c"
	eerror "41 releases due to struct changes; therefore you must NOT ENABLE"
	eerror "42 any other i2c drivers (e.g. bttv) in the kernel."
	eerror "43 Do NOT use lm-sensors 2.8.8 or i2c-2.8.8 if you require bttv."
	echo
	eerror "Please try out http://khai.linux-fr.org/devel/i2c/ for a kernel"
	eerror "patch which will fix this problem. Please note that nor the"
	eerror "lm_sensors team nor the package maintainers will be able to"
	eerror "support you if you encounter problems with I2C when using"
	eerror "other modules with requirements on I2C..."
	echo
}

src_compile ()  {
	if [ "$LINUX" != "" ]; then
		einfo "Cross-compiling using:- $LINUX"
		einfo "Using headers from:- `echo $LINUX/include/linux | sed 's/\/\//\//'`"
		LINUX=`echo $LINUX | sed 's/build\//build/'`
	else
		einfo "You are running:- `uname -r`"
		check_KV || die "Cannot find kernel in /usr/src/linux"
		einfo "Using kernel in /usr/src/linux:- ${KV}"

		echo ${KV} | grep -q 2.4.
		if [ $? == 1 ]; then
			echo
			einfo "For 2.5+ series kernels, use the support already in the kernel"
			einfo "under 'Character devices' -> 'I2C support'."
			echo
			einfo "To cross-compile, 'export LINUX=\"/lib/modules/<version>/build\"'"
			einfo "or symlink /usr/src/linux to another kernel."
			echo
			ewarn "Non-2.4 kernel detected; doing nothing..."
			return
		else
			LINUX='/usr/src/linux'
		fi

		if [ "${KV}" != "`uname -r`" ]; then
			ewarn "WARNING:- kernels do not match!"
		fi
	fi

	cd kernel;
	epatch ${FILESDIR}/i2c-2.8.0-alphaCompile.patch > /dev/null;
	cd ..;

	echo; einfo "You may safely ignore any errors from compilation"
	einfo "that contain 'No such file' references."
	echo '>>> Compiling...'

	emake CC=$(tc-getCC) LINUX=$LINUX clean all
	if [ $? != 0 ]; then
		eerror "I2C requires the source of a compatible kernel"
		eerror "version installed in /usr/src/linux"
		eerror "(or the environmental variable \$LINUX)"
		eerror "and kernel I2C *disabled* or *enabled as a module*"
		die "Error: compilation failed!"
	fi
}

src_install() {
	echo ${KV} | grep -q 2.4.
	if [ "$?" -eq '0' -o "$LINUX" != '' ]; then
		emake \
			CC=$(tc-getCC) \
			LINUX=$LINUX \
			LINUX_INCLUDE_DIR=/usr/include/linux \
			DESTDIR=${D} \
			PREFIX=/usr \
			MANDIR=/usr/share/man \
			install || die
		epause 5 # Show important warnings from the Makefile
		dodoc CHANGES INSTALL README
	fi
}

pkg_postinst() {
	if echo ${KV} | grep -q 2.4.; then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

		einfo "I2C modules installed ..."
		echo
		ewarn "IMPORTANT ... if you are installing this package you need to"
		ewarn "IMPORTANT ... *disable* kernel I2C support OR *modularize it*"
		ewarn "IMPORTANT ... if your 2.4.x kernel is patched with such support"
		echo
	fi
}
