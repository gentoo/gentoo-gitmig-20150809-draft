# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/tetex.eclass,v 1.36 2005/04/05 17:07:45 usata Exp $
#
# Author: Jaromir Malenko <malenko@email.cz>
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# A generic eclass to install tetex distributions. This shouldn't be
# inherited directly in any ebuilds. It should be inherited from
# tetex-{2,3}.eclass.

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
			unpack ${TETEX_TEXMF}

			# create update script
			cat >${T}/texmf-update<<'EOF'
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
texconfig-sys init &>/dev/null
texconfig-sys confall &>/dev/null
texconfig-sys font rw &>/dev/null
texconfig-sys font vardir /var/cache/fonts &>/dev/null
texconfig-sys font options varfonts &>/dev/null
updmap-sys &>/dev/null

# generate
echo "Generating format files ..."
fmtutil-sys --missing &>/dev/null
echo
echo "Use 'texconfig font ro' to disable font generation for users"
echo
EOF
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
			;;
    		all)
    			tetex_src_unpack unpack patch
			;;
    	esac
    	shift
    done
}

tetex_src_compile() {

	# filter -Os; bug #74307.
	filter-flags "-fstack-protector" "-Os"

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

			# Install teTeX files
			einfo "Installing teTeX ..."
			dodir ${TEXMF_PATH:-/usr/share/texmf}/web2c
			einstall bindir=${D}/usr/bin texmf=${D}${TEXMF_PATH:-/usr/share/texmf} || die

			dosbin ${T}/texmf-update
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

			#add /var/cache/fonts directory
			dodir /var/cache/fonts

			#fix for lousy upstream permisssions on /usr/share/texmf files
			#NOTE: do not use fowners, as its not recursive ...
			einfo "Fixing permissions ..."
			# root group name doesn't exist on Mac OS X
			chown -R 0:0 ${D}/usr/share/texmf
			find ${D} -name "ls-R" -exec rm {} \;
			;;
		all)
			tetex_src_install base doc fixup
			;;
	esac
	shift
	done
}

tetex_pkg_postinst() {

	if [ "$ROOT" = "/" ] ; then
		/usr/sbin/texmf-update
	fi
	if [ -d "/etc/texmf" ] ; then
		einfo
		einfo "If you have configuration files in /etc/texmf to merge,"
		einfo "please update them and run /usr/sbin/texmf-update."
		einfo
	fi
}
