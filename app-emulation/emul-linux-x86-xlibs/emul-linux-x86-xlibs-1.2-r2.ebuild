# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-1.2-r2.ebuild,v 1.1 2005/01/18 01:37:37 eradicator Exp $

inherit eutils

DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-xlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-baselibs-1.2.2-r2"

S=${WORKDIR}

src_install() {
	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=/emul/linux/x86/usr/X11R6/lib32" > ${D}/etc/env.d/75emul-linux-x86-xlibs
	cp -Rpvf ${WORKDIR}/* ${D}/

	# We don't use this symlink any more
	rm ${D}/usr/X11R6/lib32

	mkdir -p ${D}/emul/linux/x86/usr/X11R6/lib32/X11/locale/C
	cp ${FILESDIR}/XI18N_OBJS ${D}/emul/linux/x86/usr/X11R6/lib32/X11/locale/C/
	cp ${FILESDIR}/XLC_LOCALE ${D}/emul/linux/x86/usr/X11R6/lib32/X11/locale/C/

	chown -R root:root ${D}
}

pkg_postinst() {
	# do not replace any of the following with $(get_libdir)
	if [ ! -e /usr/X11R6/lib/X11/locale/lib ] ; then
		ln -s /emul/linux/x86/usr/X11R6/lib/X11/locale/lib /usr/X11R6/lib/X11/locale/lib
	elif [ ! -h /usr/X11R6/lib/X11/locale/lib ] ; then
		echo
		ewarn "/usr/X11R6/lib/X11/locale/lib isnt a symlink, some apps will"
		ewarn "refuse to work (adobe acrobat, staroffice, etc). Right now the"
		ewarn "fix is to install at least xorg 6.7.99.903, which has been made"
		ewarn "lib64 aware, and then reinstall emul-linux-x86-xlibs."
		echo
		epause 10
	fi
}
