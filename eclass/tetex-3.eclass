# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/tetex-3.eclass,v 1.3 2005/04/09 13:38:48 usata Exp $
#
# Author: Jaromir Malenko <malenko@email.cz>
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# A generic eclass to install tetex 3.x distributions.

TEXMF_PATH=/var/lib/texmf

inherit tetex

ECLASS=tetex-3
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_preinst pkg_postinst

IUSE="motif lesstif Xaw3d neXt"

DEPEND="X? ( motif? ( lesstif? ( x11-libs/lesstif )
			!lesstif? ( x11-libs/openmotif ) )
		!motif? ( neXt? ( x11-libs/neXtaw )
			!neXt? ( Xaw3d? ( x11-libs/Xaw3d ) ) )
		!app-text/xdvik
	)
	!dev-tex/memoir
	!dev-tex/lineno
	!dev-tex/SIunits
	!dev-tex/floatflt
	!dev-tex/g-brief
	!dev-tex/pgf
	!dev-tex/xcolor
	!dev-tex/xkeyval
	!dev-tex/latex-beamer"

tetex-3_pkg_setup() {
	tetex_pkg_setup
	
	ewarn
	ewarn "teTeX 3.0 ebuild will remove config files stored in /usr/share/texmf."
	ewarn "Please make a backup before upgrading if you changed anything."
	ewarn

	ebeep
	epause
}

tetex-3_src_unpack() {

	tetex_src_unpack

	# need to fix up the hyperref driver, see bug #31967
	sed -i -e "/providecommand/s/hdvips/hypertex/" \
		${S}/texmf/tex/latex/hyperref/hyperref.cfg
}

tetex-3_src_compile() {
	sed -i -e "/mktexlsr/,+3d" \
		-e "s/\(updmap-sys\)/\1 --nohash/" \
		Makefile.in || die

	use amd64 && replace-flags "-O3" "-O2"

	if use X ; then
		if use motif ; then
			if use lesstif ; then
				append-ldflags -L/usr/X11R6/lib/lesstif -R/usr/X11R6/lib/lesstif
				export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/lesstif"
			fi
			toolkit="motif"
		elif use neXt ; then
			toolkit="neXtaw"
		elif use Xaw3d ; then
			toolkit="xaw3d"
		else
			toolkit="xaw"
		fi

		TETEX_ECONF="${TETEX_ECONF} --with-xdvi-x-toolkit=${toolkit}"
	fi

	tetex_src_compile
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
