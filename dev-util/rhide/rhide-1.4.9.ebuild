# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Desktop Team <desktop@cvs.gentoo.org>
# Author:  Martin Schlemmer <azarah@gentoo.org>

TVISIONVER="1.1.3b"
SETEDITVER="0.4.41"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="5.0"

S=${WORKDIR}/${P}
DESCRIPTION="RHIDE is a console IDE for various languages."
SRC_URI="http://prdownloads.sourceforge.net/rhide/rhide-${PV}.tar.gz
	 http://prdownloads.sourceforge.net/setedit/rhtvision-${TVISIONVER}.src.tar.gz
	 http://prdownloads.sourceforge.net/setedit/setedit-${SETEDITVER}.tar.gz
	 ftp://ftp.gnu.org/gnu/gdb/gdb-${GDBVER}.tar.gz"
HOMEPAGE="http://www.rhide.com/"

# Ugly I know, but the build fails if teTeX not installed
DEPEND="virtual/glibc
	dev-libs/libpcre
	sys-devel/gettext
	app-text/tetex"
	

src_unpack() {
	
	unpack ${A}
	
	cd ${S}/../tvision/
	patch -p1 <${FILESDIR}/tvision-${TVISIONVER}.diff || die
	
	cd ${S}/../setedit/
	patch -p1 <${FILESDIR}/setedit-${SETEDITVER}.diff || die
	
	cd ${S}
	patch <${FILESDIR}/rhide-1.4.9.diff-1 || die
	patch <${FILESDIR}/rhide-1.4.9.diff-2 || die
}

src_compile() {
	
	# Most of these use a _very_ lame build system,
	# so please no comments ;/
	
# ************* TVision *************
	
	cd ${S}/../tvision/
	
	DUMMYFLAGS=""
	
	./configure --prefix=/usr				\
		--fhs						\
		--cflags='${DUMMYFLAGS}'			\
		--cxxflags='${DUMMYFLAGS}' || die
	
	# Only build the static libs
	cp Makefile Makefile.orig
	sed -e 's/all: static-lib dynamic-lib/all: static-lib/'	\
		Makefile.orig >Makefile
	
	# -j breaks build
	make || die
	
	# Fix include problem
	cp ${S}/../tvision/include/tv/* ${S}/../tvision/include
		
	
# ************* SetEdit *************
	
	cd ${S}/../setedit/
	
	./configure --prefix=/usr				\
		--fhs						\
		--libset || die
	
	# Fix CFLAGS and CXXFLAGS
	cd ${S}/../setedit/makes
	cp rhide.env rhide.env.orig
	sed -e "s:${CFLAGS}::g"					\
		-e "s:${CXXFLAGS}::g" 				\
		rhide.env.orig >rhide.env
	make clean || die
	make force-patch || die
	cd ${S}/../setedit/
	
	# -j breaks build
	make || die

	# Make the docs
	cd ${S}/../setedit/doc
	make || die
	
	
# ************* RHIDE ***************
	
	cd ${S}
	
	# Fix CFLAGS and CXXFLAGS
	cp rhide.mak rhide.mak.orig
	sed -e 's:-O2:$(CFLAGS):' rhide.mak.orig >rhide.mak
        cp rhide_.mak rhide_.mak.orig
	sed -e 's:-O2:$(CFLAGS):' rhide_.mak.orig >rhide_.mak
	cp gpr2mak.mak gpr2mak.mak.orig
	sed -e 's:-O2:$(CFLAGS):' gpr2mak.mak.orig >gpr2mak.mak
	cp gprexp.mak gprexp.mak.orig
	sed -e 's:-O2:$(CFLAGS):' gprexp.mak.orig >gprexp.mak
	
	export RHIDESRC="`pwd`"
	export SETSRC="${RHIDESRC}/../setedit"
	export SETOBJ="${RHIDESRC}/../setedit/makes"
	export TVSRC="${RHIDESRC}/../tvision"
	export TVOBJ="${RHIDESRC}/../tvision/linux"
	
	make prefix=/usr			  		\
		install_docdir=share/doc/${PF}			\
		install_infodir=share/info			\
		|| die
	
	# -j breaks build
	make || die

	# Update SetEdit and InfView's info pages
	cp -f ${S}/../setedit/doc/editor.inf			\
		${S}/share/setedit/setedit.inf
	cp -f ${S}/../setedit/doc/infeng.inf			\
		${S}/share/setedit/infview.inf

	# Fix the filenames in the info pages
	cd ${S}/share/setedit/
	cp setedit.inf setedit.inf.orig
	sed -e 's:editor.inf:setedit.inf:g'			\
		setedit.inf.orig > setedit.inf
	cp infview.inf infview.inf.orig
	sed -e 's:infeng.inf:infview.inf:g'			\
		infview.inf.orig > infview.inf
	cd ${S}
	
	# Update setedit macro's
	cp -f ${S}/../setedit/cfgfiles/*.pmc ${S}/share/setedit
}

src_install() {
	
	make prefix=${D}/usr					\
	install_docdir=share/doc/${PF}				\
	install_infodir=share/info				\
	install || die
	
	# Fix .info files
	for file in ${D}/usr/share/info/*.inf ; do
		mv ${file} ${file}o
	done

	# Install default CFG file and fix the paths
	cd ${D}/usr/share/rhide
	sed -e 's:/usr/local/share:/usr/share:g'		\
		rhide_.env >rhide.env
	echo 'INFOPATH=/usr/share/info' >> rhide.env

	# Install env file
	insinto /etc/env.d
	doins ${FILESDIR}/80rhide
}

