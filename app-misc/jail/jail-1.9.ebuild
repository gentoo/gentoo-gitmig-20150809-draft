# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Pau Oliva <pau@eSlack.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/jail/jail-1.9.ebuild,v 1.1 2002/07/27 01:48:33 raker Exp $

S="${WORKDIR}/${PN}_1-9_stable"
DESCRIPTION="Jail Chroot Project is a tool that builds a chrooted environment and automagically configures and builds all the required files, directories and libraries"
SRC_URI="http://www.gsyc.inf.uc3m.es/~assman/downloads/jail/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.gsyc.inf.uc3m.es/~assman/jail/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="virtual/glibc"
RDEPEND="sys-devel/perl"

src_unpack() {

    unpack ${PN}_${PV}.tar.gz
    cd ${S}
    patch -p0 < ${FILESDIR}/${PN}-gentoo.diff
}

src_compile() {

	# configuration files should be installed in /etc not /usr/etc
	cd ${S}
	cp install.sh install.sh.orig
	sed "s:\$4/etc:\${D}/etc:g" < install.sh.orig > install.sh

	# the destination directory should be /usr not /usr/local
	cd ${S}/src
	cp Makefile Makefile.orig
	sed "s:usr/local:${D}/usr:g" < Makefile.orig > Makefile

	emake || die "make failed"

}

src_install () {

	cd ${S}/src
	einstall || die "make install failed"

	# remove //var/tmp/portage/jail-1.9/image//usr from files
	FILES="
	/var/tmp/portage/jail-1.9/image/usr/bin/mkjailenv
	/var/tmp/portage/jail-1.9/image/usr/bin/addjailsw
	/var/tmp/portage/jail-1.9/image/usr/bin/addjailuser
	/var/tmp/portage/jail-1.9/image/etc/jail.conf
	/var/tmp/portage/jail-1.9/image/usr/lib/libjail.pm
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/generic/definitions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/generic/functions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/linux/definitions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/linux/functions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/freebsd/definitions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/freebsd/functions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/irix/definitions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/irix/functions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/solaris/definitions
	/var/tmp/portage/jail-1.9/image/usr/lib/arch/solaris/functions"

	for f in ${FILES}; do
		# documentation says funtion 'dosed' is supposed to do this, but didn't know how to make it work :'(
		# dosed ${file} || die "error in dosed"
		cp ${f} ${f}.orig
		sed "s://var/tmp/portage/jail-1.9/image//usr:/usr:g" < ${f}.orig > ${f}
		rm ${f}.orig
	done

	cd ${S}/doc 
	dodoc CHANGELOG INSTALL README SECURITY VERSION

}
