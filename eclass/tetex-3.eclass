# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/tetex-3.eclass,v 1.1 2005/04/05 17:07:45 usata Exp $
#
# Author: Jaromir Malenko <malenko@email.cz>
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# A generic eclass to install tetex 3.x distributions.

inherit tetex

ECLASS=tetex-3
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_unpack src_install pkg_preinst pkg_postinst

tetex-3_src_unpack() {

	tetex_src_unpack

	# need to fix up the hyperref driver, see bug #31967
	sed -i -e "/providecommand/s/hdvips/hypertex/" \
		${S}/texmf/tex/latex/hyperref/hyperref.cfg
}

tetex-3_src_install() {

	tetex_src_install	

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/texmf/web2c"' > ${D}/etc/env.d/98tetex
	# populate /etc/texmf
	keepdir /etc/texmf/web2c
	cd ${D}/usr/share/texmf		# not ${TEXMF_PATH}
	for d in $(find . -name config -type d | sed -e "s:\./::g") ; do
		dodir /etc/texmf/${d}
		for f in $(find ${D}usr/share/texmf/$d -maxdepth 1 -mindepth 1); do
			mv $f ${D}/etc/texmf/$d || die "mv $f failed"
			dosym /etc/texmf/$d/$(basename $f) /usr/share/texmf/$d/$(basename $f)
		done
	done
	cd -
	cd ${D}${TEXMF_PATH}
	for f in $(find . -name '*.cnf' -o -name '*.cfg' -type f | sed -e "s:\./::g") ; do
		if [ "${f/config/}" != "${f}" ] ; then
			continue
		fi
		dodir /etc/texmf/$(dirname $f)
		mv ${D}${TEXMF_PATH}/$f ${D}/etc/texmf/$(dirname $f) || die "mv $f failed."
		dosym /etc/texmf/$f ${TEXMF_PATH}/$f
	done

	# take care of updmap.cfg, fmtutil.cnf and texmf.cnf
	dodir /etc/texmf/{updmap.d,fmtutil.d,texmf.d}
	#cp ${D}/usr/share/texmf/web2c/updmap.cfg ${D}/etc/texmf/updmap.d/00updmap.cfg
	dosym /etc/texmf/web2c/updmap.cfg ${TEXMF_PATH}/web2c/updmap.cfg
	mv ${D}/usr/share/texmf/web2c/updmap.cfg ${D}/etc/texmf/updmap.d/00updmap.cfg
	mv ${D}/etc/texmf/web2c/fmtutil.cnf ${D}/etc/texmf/fmtutil.d/00fmtutil.cnf
	mv ${D}/etc/texmf/web2c/texmf.cnf ${D}/etc/texmf/texmf.d/00texmf.cnf

	# xdvi
	if useq X ; then
		dodir /etc/X11/app-defaults /etc/texmf/xdvi
		mv ${D}${TEXMF_PATH}/xdvi/XDvi ${D}/etc/X11/app-defaults || die "mv XDvi failed"
		dosym /etc/X11/app-defaults/XDvi ${TEXMF_PATH}/xdvi/XDvi
	fi
	cd -
}

tetex-3_pkg_preinst() {

	ewarn "Removing ${ROOT}usr/share/texmf/web2c"
	rm -rf "${ROOT}usr/share/texmf/web2c"

	# take care of config protection, upgrade from <=tetex-2.0.2-r4
	for conf in updmap.cfg texmf.cnf fmtutil.cnf
	do
		if [ ! -d "${ROOT}etc/texmf/${conf/.*/.d}" -a -f "${ROOT}etc/texmf/${conf}" ]
		then
			mkdir "${ROOT}etc/texmf/${conf/.*/.d}"
			cp "${ROOT}etc/texmf/${conf}" "${ROOT}etc/texmf/00${conf/.*/.d}"
		fi
	done
}

tetex-3_pkg_postinst() {

	if [ "$ROOT" = "/" ] ; then
		/usr/sbin/texmf-update
	fi
	einfo
	einfo "If you have configuration files in /etc/texmf to merge,"
	einfo "please update them and run /usr/sbin/texmf-update."
	einfo
}
