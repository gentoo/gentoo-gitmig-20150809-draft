# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation-tools/vmware-workstation-tools-4.5.2.ebuild,v 1.3 2006/05/08 13:56:33 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Guest-os tools for VMware Workstation"
HOMEPAGE="http://www.vmware.com/"

# the vmware-tools sources are part of the vmware virtual machine;
# they must be installed by hand
SRC_URI="vmware-linux-tools.tar.gz"
LICENSE="vmware"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
RESTRICT="fetch"

DEPEND=""
RDEPEND="sys-apps/pciutils"

dir=/opt/vmware/tools
Ddir=${D}/${dir}

S=${WORKDIR}/vmware-tools-distrib

src_install() {
	into ${dir}
	# install the binaries
	dosbin sbin/vmware-checkvm
	dosbin sbin/vmware-guestd
	dobin bin/vmware-config-tools.pl
	dobin bin/vmware-toolbox

	# install the config files
	insinto /etc/vmware-tools
	doins etc/{installer.sh,not_configured,{powero{ff,n},resume,suspend}-vm-default

	# install the library files
	mkdir -p ${D}/usr/lib/vmware-tools
	cp -r lib/* ${D}/usr/lib/vmware-tools

	# install the init scripts
	doinitd ${FILESDIR}/${PV}/${PN}

	# if we have X, install the default config
	if use X ; then
		insinto /etc/X11
		doins ${FILESDIR}/${PV}/xorg.conf
	fi

	dodir /etc/vmware/init.d
	dodir /etc/vmware/init.d/rc0.d
	dodir /etc/vmware/init.d/rc1.d
	dodir /etc/vmware/init.d/rc2.d
	dodir /etc/vmware/init.d/rc3.d
	dodir /etc/vmware/init.d/rc4.d
	dodir /etc/vmware/init.d/rc5.d
	dodir /etc/vmware/init.d/rc6.d

	# This is to fix a problem where if someone merges vmware and then
	# before configuring vmware they upgrade or re-merge the vmware
	# package which would rmdir the /etc/vmware/init.d/rc?.d directories.
	keepdir /etc/vmware/init.d/rc{0,1,2,3,4,5,6}.d

	# Questions:
	einfo "Adding answers to /etc/vmware/locations"
	locations="${D}/etc/vmware-tools/locations"
	echo "answer BINDIR ${dir}/bin" >> ${locations}
	echo "answer LIBDIR ${dir}/lib" >> ${locations}
	echo "answer MANDIR ${dir}/man" >> ${locations}
	echo "answer DOCDIR ${dir}/doc" >> ${locations}
	echo "answer RUN_CONFIGURATOR no" >> ${locations}
	echo "answer INITDIR /etc/vmware/init.d" >> ${locations}
	echo "answer INITSCRIPTSDIR /etc/vmware/init.d" >> ${locations}

}

pkg_postinst () {
	# This must be done after the install to get the mtimes on each file
	# right. This perl snippet gets the /etc/vmware/locations file code:
	# perl -e "@a = stat('bin/vmware'); print \$a[9]"
	# The above perl line and the find line below output the same thing.
	# I would think the find line is faster to execute.
	# find /opt/vmware/workstation/bin/vmware -printf %T@

	#Note: it's a bit weird to use ${D} in a preinst script but it should work
	#(drobbins, 1 Feb 2002)

	einfo "Generating /etc/vmware/locations file."
	d=`echo ${D} | wc -c`
	for x in `find ${Ddir} ${D}/etc/vmware` ; do
		x="`echo ${x} | cut -c ${d}-`"
		if [ -d ${D}/${x} ] ; then
			echo "directory ${x}" >> ${D}/etc/vmware/locations
		else
			echo -n "file ${x}" >> ${D}/etc/vmware/locations
			if [ "${x}" == "/etc/vmware/locations" ] ; then
				echo "" >> ${D}/etc/vmware/locations
			elif [ "${x}" == "/etc/vmware/not_configured" ] ; then
				echo "" >> ${D}/etc/vmware/locations
			else
				echo -n " " >> ${D}/etc/vmware/locations
				#perl -e "@a = stat('${D}${x}'); print \$a[9]" >> ${D}/etc/vmware/locations
				find ${D}${x} -printf %T@ >> ${D}/etc/vmware/locations
				echo "" >> ${D}/etc/vmware/locations
			fi
		fi
	done
	einfo "To start using the vmware-tools, please run the following:"
	einfo
	einfo "  /usr/bin/vmware-config-tools.pl"
	einfo "  rc-update add ${PN} default"
	einfo "  /etc/init.d/${PN} start"
	einfo
	einfo "Please report all bugs to http://bugs.gentoo.org/"
}
