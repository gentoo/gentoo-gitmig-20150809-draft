# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/tetex.eclass,v 1.31 2004/11/20 19:46:28 usata Exp $
#
# Author: Jaromir Malenko <malenko@email.cz>
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# A generic eclass to install tetex distributions.

inherit eutils flag-o-matic

ECLASS=tetex
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_setup pkg_preinst pkg_postinst

if [ -z "${TETEX_PV}" ] ; then
	TETEX_PV=${PV}
fi

IUSE="X doc"

S=${WORKDIR}/tetex-src-${TETEX_PV}
TETEX_SRC="tetex-src-${TETEX_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_PV}.tar.gz"
TETEX_TEXMF_SRC="tetex-texmfsrc-${TETEX_PV}.tar.gz"

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"
SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/2.0/distrib
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	${SRC_PATH_TETEX}/${TETEX_TEXMF_SRC}
	mirror://gentoo/tetex-${TETEX_PV}-gentoo.tar.gz
	http://dev.gentoo.org/~usata/distfiles/tetex-${TETEX_PV}-gentoo.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="!app-text/tetex
	!app-text/ptex
	!app-text/cstetex
	sys-apps/ed
	sys-libs/zlib
	X? ( virtual/x11 )
	>=media-libs/libpng-1.2.1
	sys-libs/ncurses
	>=net-libs/libwww-5.3.2-r1"
RDEPEND="${DEPEND}
	!app-text/dvipdfm
	!dev-tex/currvita
	!dev-tex/eurosym
	!dev-tex/extsizes
	>=dev-lang/perl-5.2
	dev-util/dialog"
PROVIDE="virtual/tetex"

tetex_pkg_setup() {

	# hundreds of bugs reporting "cannot find -lmysqlclient" :(
	if ! has_version 'dev-db/mysql' && (libwww-config --libs | grep mysql >/dev/null 2>&1); then
		eerror
		eerror "Your libwww was compiled with MySQL but MySQL is missing from system."
		eerror "Please install MySQL or remerge libwww without mysql USE flag."
		eerror
		die "libwww was compiled with mysql but mysql is not installed"
	fi
}

tetex_src_unpack() {

	[ -z "$1" ] && tetex_src_unpack all

	while [ "$1" ]; do
	case $1 in
		unpack)
			unpack ${TETEX_SRC}
			unpack tetex-${TETEX_PV}-gentoo.tar.gz

			mkdir ${S}/texmf; cd ${S}/texmf
			umask 022
			if [ "${TETEX_PV}" == "2.0.2" ] ; then
				unpack ${TETEX_TEXMF_SRC}
			fi
			unpack ${TETEX_TEXMF}
			;;
		patch)
			# Do not run config. Also fix local texmf tree.
			cd ${S}
			for p in ${WORKDIR}/patches/* ; do
				epatch $p
			done

			if useq ppc-macos ; then
				sed -i -e "/^HOMETEXMF/s:\$HOME/texmf:\$HOME/Library/texmf:" ${S}/texk/kpathsea/texmf.in || die "sed texmf.in failed."
			fi

			if [ "${TETEX_PV}" == "2.0.2" ] ; then
				# fix up misplaced listings.sty in the 2.0.2 archive. 
				# this should be fixed in the next release <obz@gentoo.org>
				mv texmf/source/latex/listings/listings.sty texmf/tex/latex/listings/
				# need to fix up the hyperref driver, see bug #31967
				sed -i -e "/providecommand/s/hdvips/hypertex/" \
					${S}/texmf/tex/latex/config/hyperref.cfg
			else
				sed -i -e "/providecommand/s/hdvips/hypertex/" \
					${S}/texmf/tex/latex/hyperref/hyperref.cfg
			fi
			;;
    		all)
    			tetex_src_unpack unpack patch
			;;
    	esac
    	shift
    done
}

tetex_src_compile() {

	filter-flags "-fstack-protector"

	einfo "Building teTeX"

	local xdvik

	if useq X ; then
		addwrite /var/cache/fonts
		xdvik="--with-xdvik --with-oxdvik"
		#xdvik="$xdvik --with-system-t1lib"
	else
		xdvik="--without-xdvik --without-oxdvik"
	fi

	econf --bindir=/usr/bin \
		--datadir=${S} \
		--with-system-wwwlib \
		--with-libwww-include=/usr/include/w3c-libwww \
		--with-system-ncurses \
		--with-system-pnglib \
		--without-texinfo \
		--without-dialog \
		--without-texi2html \
		--with-system-zlib \
		--disable-multiplatform \
		--with-epsfwin \
		--with-mftalkwin \
		--with-regiswin \
		--with-tektronixwin \
		--with-unitermwin \
		--with-ps=gs \
		--enable-ipc \
		--with-etex \
		$(use_with X x) \
		${xdvik} \
		${TETEX_ECONF} || die

	if useq X && useq ppc-macos ; then
		for f in $(find ${S} -name config.status) ; do
			sed -i -e "s:-ldl::g" $f
		done
	fi

	emake -j1 texmf=${TEXMF_PATH:-/usr/share/texmf} || die "make teTeX failed"
}

tetex_src_install() {

	if [ -z "$1" ]; then
		tetex_src_install all
	fi

	while [ "$1" ]; do
	case $1 in
		base)
			dodir /usr/share/
			# Install texmf files
			einfo "Installing texmf ..."
			cp -Rv texmf ${D}/usr/share

			if [ "${TETEX_PV}" == "2.0.2" ] ; then
				# bug #47004
				insinto /usr/share/texmf/tex/latex/a0poster
				doins ${S}/texmf/source/latex/a0poster/a0poster.cls || die
				doins ${S}/texmf/source/latex/a0poster/a0size.sty || die
			fi
			# Install teTeX files
			einfo "Installing teTeX ..."
			dodir ${TEXMF_PATH:-/usr/share/texmf}/web2c
			einstall bindir=${D}/usr/bin texmf=${D}${TEXMF_PATH:-/usr/share/texmf} || die
			
			# Install update script
			cat >>${T}/tetex-update<<'EOF'
#!/bin/bash
#
# Utility to update Gentoo teTeX distribution configuration files
#

PATH=/bin:/usr/bin

for conf in texmf.cnf fmtutil.cnf updmap.cfg
do
	if [ -d "/etc/texmf/${conf/.*/.d}" ]
	then
		echo "Generating /etc/texmf/web2c/${conf} from /etc/texmf/${conf/.*/.d} ..."
		cat /etc/texmf/${conf/.*/.d}/* > "/etc/texmf/web2c/${conf}"
	fi
done

# configure
echo "Configuring teTeX ..."
mktexlsr &>/dev/null
texconfig init &>/dev/null
texconfig confall &>/dev/null
texconfig font rw &>/dev/null
texconfig font vardir /var/cache/fonts &>/dev/null
texconfig font options varfonts &>/dev/null
updmap &>/dev/null

# generate
echo "Generating format files ..."
fmtutil --missing &>/dev/null
echo
echo "Use 'texconfig font ro' to disable font generation for users"
echo
EOF
			dosbin ${T}/tetex-update
			;;
		doc)
			dodoc PROBLEMS README
			docinto texk
			dodoc texk/ChangeLog texk/README
			docinto kpathesa
			cd ${S}/texk/kpathsea
			dodoc README* NEWS PROJECTS HIER
			docinto dviljk
			cd ${S}/texk/dviljk
			dodoc AUTHORS README NEWS
			docinto dvipsk
			cd ${S}/texk/dvipsk
			dodoc AUTHORS ChangeLog INSTALLATION README
			docinto makeindexk
			cd ${S}/texk/makeindexk
			dodoc CONTRIB COPYING NEWS NOTES PORTING README
			docinto ps2pkm
			cd ${S}/texk/ps2pkm
			dodoc ChangeLog CHANGES.type1 INSTALLATION README*
			docinto web2c
			cd ${S}/texk/web2c
			dodoc AUTHORS ChangeLog NEWS PROJECTS README
			#docinto xdvik
			#cd ${S}/texk/xdvik
			#dodoc BUGS FAQ README*

			# move docs to /usr/share/doc/${PF}
			if useq doc ; then
				dodir /usr/share/doc/${PF}
				mv ${D}/usr/share/texmf/doc/* \
					${D}/usr/share/doc/${PF} \
					|| die "mv doc failed."
				cd ${D}/usr/share/texmf
				rmdir doc
				ln -s ../doc/${PF} doc \
					|| die "ln -s doc failed."
				cd -
			else
				rm -rf ${D}/usr/share/texmf/doc
			fi
			;;
		fixup)
			#fix for conflicting readlink binary:
			rm -f ${D}/bin/readlink
			rm -f ${D}/usr/bin/readlink

			if [ "${TETEX_PV}" == "2.0.2" ] ; then
				# --without-texi2html doesn't exist
				rm -f ${D}/usr/bin/texi2html
				rm -f ${D}/usr/share/man/man1/texi2html.1
			fi

			#add /var/cache/fonts directory
			dodir /var/cache/fonts

			#fix for lousy upstream permisssions on /usr/share/texmf files
			#NOTE: do not use fowners, as its not recursive ...
			einfo "Fixing permissions ..."
			# root group name doesn't exist on Mac OS X
			chown -R 0:0 ${D}/usr/share/texmf
			find ${D} -name "ls-R" -exec rm {} \;
			;;
		link)	# link is for tetex-beta
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
			cp ${D}/usr/share/texmf/web2c/updmap.cfg ${D}/etc/texmf/updmap.d/00updmap.cfg
			mv ${D}/etc/texmf/web2c/fmtutil.cnf ${D}/etc/texmf/fmtutil.d/00fmtutil.cnf
			mv ${D}/etc/texmf/web2c/texmf.cnf ${D}/etc/texmf/texmf.d/00texmf.cnf

			# xdvi
			if useq X ; then
				dodir /etc/X11/app-defaults /etc/texmf/xdvi
				mv ${D}${TEXMF_PATH}/xdvi/XDvi ${D}/etc/X11/app-defaults || die "mv XDvi failed"
				dosym /etc/X11/app-defaults/XDvi ${TEXMF_PATH}/xdvi/XDvi
			fi
			cd -
			;;
		cnf)	# cnf is for tetex-2.0.2
			dodir /etc/env.d/
			echo 'CONFIG_PROTECT="/usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/platex/config/ /usr/share/texmf/dvips/config/ /usr/share/texmf/dvipdfm/config/ /usr/share/texmf/xdvi/"' > ${D}/etc/env.d/98tetex

			#fix for texlinks
			local src dst
			sed -e '/^#/d' -e '/^$/d' -e 's/^ *//' \
				${D}/usr/share/texmf/web2c/fmtutil.cnf > ${T}/fmtutil.cnf || die
			while read l; do
				dst=/usr/bin/`echo $l | awk '{ print $1 }'`
				src=/usr/bin/`echo $l | awk '{ print $2 }'`
				if [ ! -f ${D}$dst -a "$dst" != "$src" ] ; then
					einfo "Making symlinks from $src to $dst"
					dosym $src $dst
				fi
			done < ${T}/fmtutil.cnf
			;;
		all)
			tetex_src_install base doc fixup cnf
			#tetex_src_install base doc fixup link
			;;
	esac
	shift
	done
}

tetex_pkg_preinst() {

	if [ "${TETEX_PV}" != "2.0.2" ] ; then
		ewarn "Removing ${ROOT}usr/share/texmf/web2c"
		rm -rf "${ROOT}usr/share/texmf/web2c"
	fi

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

tetex_pkg_postinst() {

	if [ "$ROOT" = "/" ] ; then
		/usr/sbin/tetex-update
	fi
	if [ -d "/etc/texmf" ] ; then
		einfo
		einfo "If you have configuration files in /etc/texmf to merge,"
		einfo "please update them and run /usr/sbin/tetex-update."
		einfo
	fi
}
