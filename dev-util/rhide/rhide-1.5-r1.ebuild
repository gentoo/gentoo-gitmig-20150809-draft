# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rhide/rhide-1.5-r1.ebuild,v 1.2 2003/04/24 11:01:46 vapier Exp $

#SNAPSHOT="20020825"
TVISIONVER="2.0.1"
SETEDITVER="0.5.0"
SETEDIT_S="setedit"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="5.3"

DESCRIPTION="console IDE for various languages"
if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${P}"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
else
	S="${WORKDIR}/${P/_}-${SNAPSHOT}"
	SRC_URI="http://rhide.sourceforge.net/snapshots/${P/_}-${SNAPSHOT}.tar.gz
		mirror://gentoo/${P/_}-${SNAPSHOT}.tar.gz"
fi
SRC_URI="${SRC_URI}
	mirror://sourceforge/tvision/rhtvision-${TVISIONVER}.src.tar.gz
	mirror://sourceforge/setedit/setedit-${SETEDITVER}.tar.gz
	mirror://gnu/gdb/gdb-${GDBVER}.tar.bz2"
HOMEPAGE="http://www.rhide.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="X"

DEPEND="virtual/glibc
	>=app-text/recode-3.6
	>=dev-libs/libpcre-2.0.6
	>=sys-apps/bzip2-1.0.1
	>=sys-apps/texinfo-4.1
	>=sys-devel/gettext-0.11.0
	>=dev-lang/perl-5.6
	>=sys-libs/zlib-1.1.4
	>=sys-libs/gpm-1.20.0
	>=sys-libs/ncurses-5.2
	aalib? ( media-libs/aalib )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Get it to work with rhtvision-2.0
	epatch ${FILESDIR}/${P}-rhtvision2.patch

	cd ${WORKDIR}/${SETEDIT_S}
	# Fix an include problem with official setedit-0.5.0
	epatch ${FILESDIR}/setedit-${SETEDITVER}-fix-includes.patch
	
	# Update snapshot version
	if [ -n "${SNAPSHOT}" ]
	then
		perl -pi -e "s|1998-11-29|${SNAPSHOT}|" ${S}/idemain.cc
	else
		perl -pi -e "s|1998-11-29|`date +%F`|" ${S}/idemain.cc
	fi

	cd ${S}
	# Fix invalid "-O2" in CFLAGS and CXXFLAGS
	for x in configure $(find . -name '*.mak') $(find . -name 'makefile.src')
	do
		[ -f "${x}" ] && perl -pi -e 's:-O2::g' ${x}
	done

	# Update setedit macro's
	for x in ${WORKDIR}/${SETEDIT_S}/cfgfiles/*
	do
		[ -f "${x}" ] && cp -f ${x} ${S}/share/setedit
	done

	# Hack to uncomment a needed variable
	perl -pi -e 's|//cmcUpdateCodePage|cmcUpdateCodePage|' \
		${WORKDIR}/${SETEDIT_S}/include/ced_coma.h
}

src_compile() {
	
	# Most of these use a _very_ weird build systems,
	# so please no comments ;/
	
# ************* TVision *************

	if [ ! -f "${WORKDIR}/.tvision" ]
	then
		cd ${WORKDIR}/tvision || die "TVision source dir do not exist!"
	
		DUMMYFLAGS=""
	
		./configure --prefix=/usr \
			--fhs \
			--cflags='${DUMMYFLAGS}' \
			--cxxflags='${DUMMYFLAGS}' || die
	
		# Only build the static libs
		perl -pi -e 's/all: static-lib dynamic-lib/all: static-lib/' Makefile
	
		# -j breaks build
		make || die

		touch ${WORKDIR}/.tvision
	fi

	
# ************* SetEdit *************
	
	if [ ! -f "${WORKDIR}/.setedit" ]
	then
		cd ${WORKDIR}/${SETEDIT_S} || die "SetEdit source dir do not exist!"
	
		./configure --prefix=/usr \
			--fhs \
			--libset \
			--without-mp3 \
			`use_with aalib aa` || die

		# Latest texinfo breaks docs, so disable for now ...
		perl -pi -e 's/needed: internac doc-basic/needed: internac/' \
			Makefile
	
		# -j breaks build
		make || die

		# Make the docs
		cd ${WORKDIR}/${SETEDIT_S}/doc
#		make || die

		touch ${WORKDIR}/.setedit
	fi
	
	
# ************* RHIDE ***************
	
	cd ${S}

	addpredict "/usr/share/rhide"

	export RHIDESRC="${S}"
	export SETSRC="${WORKDIR}/${SETEDIT_S}"
	export SETOBJ="${WORKDIR}/${SETEDIT_S}/makes"
	export TVSRC="${WORKDIR}/tvision"
	export TVOBJ="${WORKDIR}/tvision/linux"
	export GDB_SRC="${WORKDIR}/gdb-${GDBVER}"

	#
	# *** DETECT XFREE86 with tvision-2.0 ***
	#
	# None of these packages have any way to specify XFree86 support,
	# thus we check if tvision compiled with xfree support or not.
	#
	# If it did compile with xfree support, we need to get rhide to link
	# against libX11 ...
	#
	local have_xfree="$(gawk '/HAVE_X11/ { if (/yes/) print "Yes" }' \
	                    ${WORKDIR}/tvision/configure.cache)"

	if [ ! -f "${WORKDIR}/.rhide-configured" ]
	then
		econf || die
		
		if [ "${have_xfree}" = "Yes" ]
		then
			einfo "Compiling with XFree86 support..."
			perl -pi -e 's|LDFLAGS= |LDFLAGS= -L/usr/X11R6/lib -lXmu|' \
				${S}/config.env

			touch ${WORKDIR}/.tvision-with-X11
		else
			einfo "Compiling without XFree86 support..."
		fi

		touch "${WORKDIR}/.rhide-configured"
	fi
		
	# -j breaks build
	make prefix=/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		LDFLAGS="${LDFLAGS} ${myLDFLAGS}" || die
	
	# Update and Fix DIR entry in .info files
	cd ${S}/share/setedit/
	if [ -f "${WORKDIR}/${SETEDIT_S}/doc/editor.inf" ]
	then
		sed -e 's:editor.inf:setedit.info:g' \
			${WORKDIR}/${SETEDIT_S}/doc/editor.inf > setedit.inf
	fi
	if [ -f "${WORKDIR}/${SETEDIT_S}/doc/infeng.inf" ]
	then
		sed -e 's:infeng.inf:infview.info:g' \
			${WORKDIR}/${SETEDIT_S}/doc/infeng.inf > infview.inf
	fi
	cd ${S}
}

src_install() {

	# Dont error out on sandbox violations.  I should really
	# try to track this down, but its a bit tougher than usually.
	addpredict "/:/usr/share/rhide:/libide:/libtvuti:/librhuti"
	
	make prefix=${D}/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		install || die
	
	# Install default CFG file and fix the paths
	cd ${D}/usr/share/rhide
	sed -e 's:/usr/local/share:/usr/share:g' \
		rhide_.env >rhide.env
	echo 'INFOPATH=/usr/share/info' >> rhide.env

	# Install sample TVision config file
	insinto /etc
	doins ${FILESDIR}/tvrc

	# Install env file
	insinto /etc/env.d
	doins ${FILESDIR}/80rhide

	# We only need the Eterm stuff if TVision was not compiled
	# with X11 support ...
	if [ ! -f "${WORKDIR}/.tvision-with-X11" ]
	then
		# Install the terminfo file
		tic -o ${D}/usr/share/terminfo \
			${WORKDIR}/tvision/extra/eterm/xterm-eterm-tv
		insinto /usr/share/Eterm/themes/Setedit

		dosed 's:Eterm --title:Eterm --theme Setedit --title:' /usr/bin/rhidex
		dosed 's:Eterm --title:Eterm --theme Setedit --title:' /usr/bin/rhgdbx

		# Install the Eterm theme
		for x in ${WORKDIR}/tvision/extra/eterm/Setedit/*
		do
			[ -f "${x}" ] && doins ${x}
		done
	else
		rm -f ${D}/usr/bin/{rhide,rhgdb}x
	fi

	# Fix .info files
	for x in ${D}/usr/share/info/*.inf
	do
		[ -f "${x}" ] && mv -f ${x} ${x}o
	done

	# Install the manpages
	for x in ${WORKDIR}/${SETEDIT_S}/doc/*.1
	do
		[ -f "${x}" ] && doman ${x}
	done

	cd ${S}
	dodoc todo
	cd ${WORKDIR}/tvision
	docinto tvision
	dodoc THANKS TODO borland.txt change.log change1.log readme.txt doc/*.txt
	cd ${WORKDIR}/${SETEDIT_S}
	docinto setedit
	dodoc README TODO change.log change0.log copying.*
}

pkg_postinst() {
	if [ -x "${ROOT}/usr/bin/rhidex" ]
	then
		echo
		einfo "You might consider installing Eterm to be able to use the rhidex"
		einfo "version of RHIDE that have better keyboard support under X:"
		echo
		einfo "  # emerge eterm"
		echo
	fi
}
