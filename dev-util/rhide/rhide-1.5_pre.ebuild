# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/rhide/rhide-1.5_pre.ebuild,v 1.1 2002/08/21 04:52:44 azarah Exp $

SNAPSHOT="20020726"
TVISIONVER="1.1.4"
SETEDITVER="0.4.57"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="5.2"

DESCRIPTION="RHIDE is a console IDE for various languages."
if [ -z "${SNAPSHOT}" ] ; then
	S="${WORKDIR}/${P}"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
else
	S="${WORKDIR}/${P/_}-${SNAPSHOT}"
	SRC_URI="http://rhide.sourceforge.net/snapshots/${P/_}-${SNAPSHOT}.tar.gz"
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
	app-text/recode
	dev-libs/libpcre
	sys-apps/bzip2
	sys-apps/texinfo
	sys-devel/gettext
	sys-libs/gpm
	sys-libs/zlib"
#	app-text/tetex"


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
	cp Makefile Makefile.orig
	sed -e 's/all: static-lib dynamic-lib/all: static-lib/'	\
		Makefile.orig >Makefile
	
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
	
	# Fix invalid "-O2" in CFLAGS and CXXFLAGS
	cp configure configure.orig
	sed -e 's:CFLAGS="-g -O2":CFLAGS="-g":' \
	    -e 's:CFLAGS="-O2":CFLAGS="":' \
	    configure.orig > configure

	# Fix a dependency due to a broken .mak file
	cp rh_comm.mak rh_comm.mak.orig
	sed -e 's:../../../../::g' rh_comm.mak.orig > rh_comm.mak

	export RHIDESRC="${S}"
	export SETSRC="${WORKDIR}/setedit"
	export SETOBJ="${WORKDIR}/setedit/makes"
	export TVSRC="${WORKDIR}/tvision"
	export TVOBJ="${WORKDIR}/tvision/linux"
	export GDB_SRC="${WORKDIR}/gdb-${GDBVER}"

	econf || die
	
	make prefix=/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		|| die
	
	# -j breaks build
	make || die

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
	
	make prefix=${D}/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		install || die
	
	# Fix .info files
	for file in ${D}/usr/share/info/*.inf
	do
		mv ${file} ${file}o
	done

	doman ${WORKDIR}/setedit/doc/{infview.1,setedit.1}

	# Install default CFG file and fix the paths
	cd ${D}/usr/share/rhide
	sed -e 's:/usr/local/share:/usr/share:g' \
		rhide_.env >rhide.env
	echo 'INFOPATH=/usr/share/info' >> rhide.env

	# Install env file
	insinto /etc/env.d
	doins ${FILESDIR}/80rhide
}

