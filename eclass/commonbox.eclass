# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/commonbox.eclass,v 1.20 2003/04/23 00:22:48 lostlogic Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The commonbox eclass is designed to allow easier installation of the box
# window managers such as blackbox and fluxbox and commonbox
# The common utilities of those window managers get installed in the
# commonbox-utils dependency, and default styles with the commonbox-styles
# utility.  They all share the /usr/share/commonbox directory now.

ECLASS=commonbox
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install pkg_postinst

DEPEND="dev-util/pkgconfig
	=sys-apps/sed-4*"

RDEPEND="nls? ( sys-devel/gettext )
	x11-misc/commonbox-utils
	x11-themes/commonbox-styles"
	
PROVIDE="virtual/blackbox"

myconf=""
mydoc=""
BOOTSTRAP=""
FORCEXFT=""

if [ -z "${MYBIN}" ]
then
	MYBIN="${PN}"
fi

commonprep() {

	sed -i -e 's:data ::' ${S}/Makefile.am

	sed -i -e 's:bsetbg::; s:bsetroot::' ${S}/util/Makefile.am

	sed -i -e 's:bsetroot.1::; s:bsetbg.1::' ${S}/doc/Makefile.am

	for i in `find ${S} -name 'Makefile.am'`
	do
		sed -i -e 's:$(pkgdatadir)/nls:/usr/share/locale:' ${i}
	done

	for i in `find ${S}/nls -name 'Makefile.am'`
	do
		sed -i -e "s:blackbox.cat:${MYBIN}.cat:g; s:${PN}.cat:${MYBIN}.cat:g" ${i}
	done

	for i in `find ${S}/src -name 'Makefile*'`
	do
		sed -i -e "s:/styles/Results:/styles/Fury-NG:" \
		       -e "s:/styles/mbdtex:/styles/Fury-NG:" \
		       -e "s:/styles/Clean:/styles/Fury-NG:" ${i}
	done
	
}

commonbox_src_compile() {

	commonprep

	if [ -z "${BOOTSTRAP}" ]
	then
		aclocal
		automake
		autoconf
	else
		./bootstrap
	fi

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
		--sysconfdir=/etc/X11/${MYBIN} \
		--datadir=/usr/share/commonbox \
		${myconf} || die

	[ ! -z "${FORCEXFT}" ] && echo "#define XFT 1" >> ${S}/config.h
	
	emake \
		pkgdatadir=/usr/share/commonbox || die
		
}


commonbox_src_install() {

	dodir /usr/share/commonbox/${PN}

	make DESTDIR=${D} install || die

	# move the ${PN} binary to ${MYBIN}

	if [ "${MYBIN}" != "${PN}" ]
	then
		mv ${D}/usr/bin/${PN} ${D}/usr/bin/${MYBIN}
	
		# same to manpage
		rm ${D}/usr/share/man/man1/${PN}.1
		mv doc/${PN}.1 doc/${MYBIN}.1
		doman doc/${MYBIN}.1
	fi

	dodoc README* AUTHORS TODO* ${mydoc}

	# move nls stuff
	use nls && ( \
		dodir /usr/share/commonbox/${MYBIN}
		mv ${D}/usr/share/${PN}/nls ${D}/usr/share/commonbox/${MYBIN}
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
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo "! ${MYBIN} no longer uses /usr/share/${MYBIN} as the  !"
		einfo "! default share directory to contain styles and menus.      !"
		einfo "! The default directory is now /usr/share/commonbox	 !"
		einfo "! Please move any files in /usr/share/${MYBIN} that you  !"
		einfo "! wish to keep (personal styles and your menu) into the     !"
		einfo "! new directory and modify your menu files to point all     !"
		einfo "! listed paths to the new directory.			       !"
		einfo "! Also, be sure to update the paths in each user's	       !"
		einfo "! config file found in their home directory.		       !"
		einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		einfo
	fi

	commonbox-menugen -kg
}
