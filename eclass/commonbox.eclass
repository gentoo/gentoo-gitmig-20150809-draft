# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/commonbox.eclass,v 1.7 2002/09/03 10:48:03 seemant Exp $

# The commonbox eclass is designed to allow easier installation of the box
# window managers such as blackbox and fluxbox and commonbox
# The common utilities of those window managers get installed in the
# commonbox-utils dependency, and default styles with the commonbox-styles
# utility.  They all share the /usr/share/commonbox directory now.

ECLASS=commonbox
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install pkg_postinst

DEPEND="x11-misc/commonbox-utils
	x11-themes/commonbox-styles"

RDEPEND="nls? ( sys-devel/gettext )"
PROVIDE="virtual/blackbox"

myconf=""
mydoc=""
MYBIN=""
commonise=1

commonify() {
	cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:\(SUBDIRS = \).*:\1doc nls src:" \
		Makefile.orig > Makefile
}

commondoc() {
	cd ${S}/doc

	cp Makefile Makefile.orig
	sed -e "s:bsetroot.1::" \
		-e "s:bsetbg.1::" \
		Makefile.orig > Makefile
	
	cd ${S}
}

sharedir() {
	cd ${S}/src
	cp Makefile Makefile.orig
#	sed -e 's:$(pkgdatadir)/menu:\\"/usr/share/commonbox/menu\\":' \
#		-e 's:$(pkgdatadir)/styles:\\"/usr/share/commonbox/styles:' \
#		-e 's:\(DEFAULT_INITFILE\).*:\1=\\"/usr/share/commonbox/init\\":' \
#		Makefile.orig > Makefile

	cd ${S}

}

commonbox_src_compile() {

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use kde \
		&& myconf="${myconf} --enable-kde" \
		|| myconf="${myconf} --disable-kde"

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	econf \
		--sysconfdir=/etc/X11/${PN} \
		--datadir=/usr/share/commonbox \
		${myconf} || die
	
	if [ ! -z $commonise ] 
	then
		commonify || die
	fi
	commondoc || die
	sharedir || die

	emake \
		pkgdatadir="/usr/share/commonbox" || die
}


commonbox_src_install() {

	dodir /usr/share/commonbox
	einstall \
		pkgdatadir="${D}/usr/share/commonbox" || die

	dodoc README* AUTHORS TODO* ${mydoc}

	if [ -z "${MYBIN}" ]
	then
		MYBIN=${PN}
	fi

	# move nls stuff
	use nls && ( \
		dodir /usr/share/commonbox/${MYBIN}
		mv ${D}/usr/share/${MYBIN}/nls ${D}/usr/share/commonbox/${MYBIN}
	)
	
	rmdir ${D}/usr/share/${MYBIN}
	
	dodir /etc/X11/Sessions
	echo "/usr/bin/${MYBIN}" > ${D}/etc/X11/Sessions/${MYBIN}
	fperms a+x /etc/X11/Sessions/${MYBIN}
}

commonbox_pkg_postinst() {
	#notify user about the new share dir
	if [ -d /usr/share/commonbox ]
	then
		einfo
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo "! ${PN} no longer uses /usr/share/${PN} as the          !"
		einfo "! default share directory to contain styles and menus.  !"
		einfo "! The default directory is now /usr/share/commonbox     !"
		einfo "! Please move any files in /usr/share/${PN} that you    !"
		einfo "! wish to keep (personal styles and your menu) into the !"
		einfo "! new directory and modify your menu files to point all !"
		einfo "! listed paths to the new directory.				       !"
		einfo "! Also, be sure to update the paths in each user's	   !"
		einfo "! config file found in their home directory.	           !"
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo
	fi
}
