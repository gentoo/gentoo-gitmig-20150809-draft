# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/rhide/rhide-1.5_pre-r1.ebuild,v 1.1 2002/09/22 07:14:06 azarah Exp $

SNAPSHOT="20020825"
TVISIONVER="1.1.4"
SETEDITVER="0.4.57"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="5.2.1"

DESCRIPTION="RHIDE is a console IDE for various languages."
if [ -z "${SNAPSHOT}" ] ; then
	S="${WORKDIR}/${P}"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
else
	S="${WORKDIR}/${P/_}-${SNAPSHOT}"
	SRC_URI="http://rhide.sourceforge.net/snapshots/${P/_}-${SNAPSHOT}.tar.gz
		mirror://gentoo/${P/_}-${SNAPSHOT}.tar.gz"
fi
SRC_URI="${SRC_URI}
	mirror://sourceforge/setedit/rhtvision-${TVISIONVER}.src.tar.gz
	mirror://sourceforge/setedit/setedit-${SETEDITVER}.tar.gz
	ftp://sourceware.cygnus.com/pub/gdb/releases/gdb-${GDBVER}.tar.gz"
HOMEPAGE="http://www.rhide.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	app-text/tetex
	>=app-text/recode-3.6
	>=dev-libs/libpcre-2.0.6
	>=sys-apps/bzip2-1.0.1
	>=sys-apps/texinfo-4.1
	>=sys-devel/gettext-0.11.0
	>=sys-devel/perl-5.6
	>=sys-libs/zlib-1.1.4
	>=sys-libs/gpm-1.20.0
	>=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"

RDEPEND="${DEPEND}
	X? ( x11-terms/eterm )"


src_unpack() {
	
	unpack ${A}

	cd ${S}
	# Get it to compile with gdb-5.2.1
	# <azarah@gentoo.org> (22 Sep 2002)
	patch -p1 < ${FILESDIR}/${P}-gdb521-IS_FP_REGNUM.patch || die
	patch -p1 < ${FILESDIR}/${P}-gdb521-REGISTER_NAMES.patch || die

	cd ${WORKDIR}/tvision
	# Get tvision-1.1.4 to compile with gcc-3.1 or later
	# <azarah@gentoo.org> (22 Sep 2002)
	patch -p1 < ${FILESDIR}/tvision-1.1.4-gcc31-filebuf.patch || die
}

src_compile() {
	
	# Most of these use a _very_ weird build systems,
	# so please no comments ;/
	
# ************* TVision *************
	
	cd ${WORKDIR}/tvision/
	
	DUMMYFLAGS=""
	
	./configure --prefix=/usr \
		--fhs \
		--cflags='${DUMMYFLAGS}' \
		--cxxflags='${DUMMYFLAGS}' || die
	
	# Only build the static libs
	perl -pi -e 's/all: static-lib dynamic-lib/all: static-lib/' Makefile
	
	# -j breaks build
	make || die

	
# ************* SetEdit *************
	
	cd ${WORKDIR}/setedit/
	
	./configure --prefix=/usr \
		--fhs \
		--libset || die
	
	# -j breaks build
	make || die

	# Make the docs
	cd ${WORKDIR}/setedit/doc
	make || die
	
	
# ************* RHIDE ***************
	
	cd ${S}

	addpredict "/usr/share/rhide"

	# Update snapshot version
	if [ -n "${SNAPSHOT}" ]
	then
		perl -pi -e "s|1998-11-29|${SNAPSHOT}|" ${S}/idemain.cc
	fi
	
	# Fix invalid "-O2" in CFLAGS and CXXFLAGS
	for x in configure $(find . -name '*.mak') $(find . -name 'makefile.src')
	do
		if [ -f ${x} ]
		then
			perl -pi -e 's:-O2::g' ${x}
		fi
	done

	# Fix a dependency due to a broken .mak file
	perl -pi -e 's:../../../../::g' rh_comm.mak

	export RHIDESRC="${S}"
	export SETSRC="${WORKDIR}/setedit"
	export SETOBJ="${WORKDIR}/setedit/makes"
	export TVSRC="${WORKDIR}/tvision"
	export TVOBJ="${WORKDIR}/tvision/linux"
	export GDB_SRC="${WORKDIR}/gdb-${GDBVER}"

	econf || die
	
	#
	# *** DETECT XFREE86 with tvision-2.0 ***
	#
	# None of these packages have any way to specify XFree86 support,
	# thus we check if tvision compiled with xfree support or not.
	#
	# If it did compile with xfree support, we need to get rhide to link
	# against libX11 ...
	#
	local myLDFLAGS=""
	local have_xfree="$(gawk '/HAVE_X11/ { if (/yes/) print "Have XFree86" }' \
	                    ${WORKDIR}/tvision/configure.cache)"

	if [ "${have_xfree}" = "Have XFree86" ]
	then
		einfo "Compiling with XFree86 support..."
		myLDFLAGS="-L/usr/X11R6/lib -lX11"
	else
		einfo "Compiling without XFree86 support..."
	fi
	#
	# *** DETECT XFREE86 ***
	#
		
	# -j breaks build
	make prefix=/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		LDFLAGS="${LDFLAGS} ${myLDFLAGS}" || die
	
	# Update and Fix DIR entry in .info files
	cd ${S}/share/setedit/
	sed -e 's:editor.inf:setedit.info:g' \
		${WORKDIR}/setedit/doc/editor.inf > setedit.inf
	sed -e 's:infeng.inf:infview.info:g' \
		${WORKDIR}/setedit/doc/infeng.inf > infview.inf
	cd ${S}
	
	# Update setedit macro's
	cp -f ${WORKDIR}/setedit/cfgfiles/*.pmc ${S}/share/setedit
}

src_install() {

	# Dont error out on sandbox violations.  I should really
	# try to track this down, but its a bit tougher than usually.
	addpredict "/:/usr/share/rhide:/libide:/libtvuti:/librhuti"
	
	make prefix=${D}/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		install || die
	
	# Fix .info files
	for file in ${D}/usr/share/info/*.inf
	do
		if [ -f ${file} ]
		then
			mv -f ${file} ${file}o
		fi
	done

	# Install the manpages
	cd ${WORKDIR}/setedit/doc
	doman infview.1 setedit.1

	# Install default CFG file and fix the paths
	cd ${D}/usr/share/rhide
	sed -e 's:/usr/local/share:/usr/share:g' \
		rhide_.env >rhide.env
	echo 'INFOPATH=/usr/share/info' >> rhide.env

	# Install the terminfo file
	tic -o ${D}/usr/share/terminfo \
		${WORKDIR}/tvision/extra/eterm/xterm-eterm-tv

	# Install env file
	insinto /etc/env.d
	doins ${FILESDIR}/80rhide
}

