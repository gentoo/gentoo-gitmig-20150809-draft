# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation/vmware-workstation-4.5.2.8848-r5.ebuild,v 1.4 2005/04/08 18:04:57 wolf31o2 Exp $

# Unlike many other binary packages the user doesn't need to agree to a licence
# to download VMWare. The agreeing to a licence is part of the configure step
# which the user must run manually.

inherit eutils

S=${WORKDIR}/vmware-distrib
ANY_ANY="vmware-any-any-update89"
NP="VMware-workstation-4.5.2-8848"
DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/desktop/ws_features.html"
SRC_URI="http://vmware-svca.www.conxion.com/software/wkst/${NP}.tar.gz
	http://download3.vmware.com/software/wkst/${NP}.tar.gz
	http://download.vmware.com/htdocs/software/wkst/${NP}.tar.gz
	http://www.vmware.com/download1/software/wkst/${NP}.tar.gz
	ftp://download1.vmware.com/pub/software/wkst/${NP}.tar.gz
	http://vmware-chil.www.conxion.com/software/wkst/${NP}.tar.gz
	http://vmware-heva.www.conxion.com/software/wkst/${NP}.tar.gz
	http://vmware.wespe.de/software/wkst/${NP}.tar.gz
	ftp://vmware.wespe.de/pub/software/wkst/${NP}.tar.gz
	http://ftp.cvut.cz/vmware/${ANY_ANY}.tar.gz
	http://ftp.cvut.cz/vmware/obselete/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/obselete/${ANY_ANY}.tar.gz
	mirror://gentoo/vmware.png"

LICENSE="vmware"
IUSE=""
SLOT="0"
KEYWORDS="-* x86 amd64"
RESTRICT="nostrip"

DEPEND=">=dev-lang/perl-5
	virtual/os-headers"

RDEPEND=">=dev-lang/perl-5
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	sys-libs/glibc
	virtual/x11
	sys-apps/pciutils"

dir=/opt/vmware
Ddir=${D}/${dir}

src_unpack() {
	unpack ${NP}.tar.gz
	cd ${S}
	unpack ${ANY_ANY}.tar.gz
	mv -f ${ANY_ANY}/*.tar ${S}/lib/modules/source/
	cd ${S}/${ANY_ANY}
	chmod 755 ../lib/bin/vmware ../bin/vmnet-bridge ../lib/bin/vmware-vmx ../lib/bin-debug/vmware-vmx
	# vmware any89 still doesn't patch the vmware binary
	#./update vmware ../lib/bin/vmware || die
	./update bridge ../bin/vmnet-bridge || die
	./update vmx ../lib/bin/vmware-vmx || die
	./update vmxdebug ../lib/bin-debug/vmware-vmx || die
}

src_install() {
	dodir ${dir}/bin
	cp -a bin/* ${Ddir}/bin

	dodir ${dir}/lib
	cp -dr lib/* ${Ddir}/lib
	# Since with Gentoo we compile everthing it doesn't make sense to keep
	# the precompiled modules arround. Saves about 4 megs of disk space too.
	rm -rf ${Ddir}/lib/modules/binary
	# We also remove the rpath libgdk_pixbuf stuff, to resolve bug #81344.
	sed -i -e 's#/tmp/rrdharan/out#/opt/vmware/null/#sg' \
		${Ddir}/lib/lib/libgdk_pixbuf.so.2/lib{gdk_pixbuf.so.2,pixbufloader-{xpm,png}.so.1.0.0} \
		|| die "Removing rpath"
	# We set vmware-vmx and vmware-ping suid
	chmod u+s ${Ddir}/bin/vmware-ping
	chmod u+s ${Ddir}/lib/bin/vmware-vmx

	dodoc doc/*

	doman ${dir}/man/man1/vmware.1.gz

	# vmware service loader
	newinitd ${FILESDIR}/vmware.rc vmware || die

	# vmware enviroment
	doenvd ${FILESDIR}/90vmware || die

	dodir /etc/vmware/
	cp -a etc/* ${D}/etc/vmware/

	dodir /etc/vmware/init.d
	dodir /etc/vmware/init.d/rc0.d
	dodir /etc/vmware/init.d/rc1.d
	dodir /etc/vmware/init.d/rc2.d
	dodir /etc/vmware/init.d/rc3.d
	dodir /etc/vmware/init.d/rc4.d
	dodir /etc/vmware/init.d/rc5.d
	dodir /etc/vmware/init.d/rc6.d
	cp -a installer/services.sh ${D}/etc/vmware/init.d/vmware || die

	# This is to fix a problem where if someone merges vmware and then
	# before configuring vmware they upgrade or re-merge the vmware
	# package which would rmdir the /etc/vmware/init.d/rc?.d directories.
	keepdir /etc/vmware/init.d/rc{0,1,2,3,4,5,6}.d

	# A simple icon I made
	insinto ${dir}/lib/icon
	doins ${DISTDIR}/vmware.png || die
	doicon ${DISTDIR}/vmware.png || die

	make_desktop_entry vmware "VMWare Workstation" vmware.png

	dodir /usr/bin
	dosym ${dir}/bin/vmware /usr/bin/vmware

	# this removes the user/group warnings
	chown -R root:root ${D}

	# Questions:
	einfo "Adding answers to /etc/vmware/locations"
	locations="${D}/etc/vmware/locations"
	echo "answer BINDIR /opt/vmware/bin" >> ${locations}
	echo "answer LIBDIR /opt/vmware/lib" >> ${locations}
	echo "answer MANDIR /opt/vmware/man" >> ${locations}
	echo "answer DOCDIR /opt/vmware/doc" >> ${locations}
	echo "answer RUN_CONFIGURATOR no" >> ${locations}
	echo "answer INITDIR /etc/vmware/init.d" >> ${locations}
	echo "answer INITSCRIPTSDIR /etc/vmware/init.d" >> ${locations}
}

pkg_preinst() {
	# This must be done after the install to get the mtimes on each file
	# right. This perl snippet gets the /etc/vmware/locations file code:
	# perl -e "@a = stat('bin/vmware'); print \$a[9]"
	# The above perl line and the find line below output the same thing.
	# I would think the find line is faster to execute.
	# find /opt/vmware/bin/vmware -printf %T@

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
}

pkg_config() {
	einfo "Running ${dir}/bin/vmware-config.pl"
	${dir}/bin/vmware-config.pl
}

pkg_postinst() {
	# This is to fix the problem where the not_configured file doesn't get
	# removed when the configuration is run. This doesn't remove the file
	# It just tells the vmware-config.pl script it can delete it.
	einfo "Updating /etc/vmware/locations"
	for x in /etc/vmware/._cfg????_locations ; do
		if [ -f $x ] ; then
			cat $x >> /etc/vmware/locations
			rm $x
		fi
	done

	einfo
	einfo "You need to run /opt/vmware/bin/vmware-config.pl to complete the install."
	einfo
	einfo "For VMware Add-Ons just visit"
	einfo "http://www.vmware.com/download/downloadaddons.html"
	einfo
	einfo "After configuring, type 'vmware' to launch"
	einfo
	einfo "Also note that when you reboot you should run:"
	einfo "/etc/init.d/vmware start"
	einfo "before trying to run vmware.  Or you could just add"
	einfo "it to the default run level:"
	einfo "rc-update add vmware default"
	echo
	#ewarn "For users of glibc-2.3.x, vmware-nat support is *still* broken on 2.6.x"
}

pkg_postrm() {
	einfo
	einfo "To remove all traces of vmware you will need to remove the files"
	einfo "in /etc/vmware/, /etc/init.d/vmware, /lib/modules/*/misc/vm*.o,"
	einfo "and .vmware/ in each users home directory. Don't forget to rmmod the"
	einfo "vm* modules, either."
	einfo
}
