# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rhide/rhide-1.4.9-r1.ebuild,v 1.4 2002/07/23 13:28:37 seemant Exp $

TVISIONVER="1.1.3b"
SETEDITVER="0.4.41"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="5.0"

S=${WORKDIR}/${P}
DESCRIPTION="RHIDE is a console IDE for various languages."
SRC_URI="http://download.sourceforge.net/rhide/${P}.tar.gz
	 http://download.sourceforge.net/setedit/rhtvision-${TVISIONVER}.src.tar.gz
	 http://download.sourceforge.net/setedit/setedit-${SETEDITVER}.tar.gz
	 ftp://ftp.gnu.org/gnu/gdb/gdb-${GDBVER}.tar.gz"
HOMEPAGE="http://www.rhide.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# Ugly I know, but the build fails if teTeX not installed
DEPEND="dev-libs/libpcre
	sys-apps/texinfo
	sys-devel/gettext
	sys-libs/gpm
	sys-libs/zlib
	app-text/tetex"


src_unpack() {

	unpack ${A}

	cd ${S}/../tvision/
	patch -p1 <${FILESDIR}/tvision-${TVISIONVER}.diff || die

	cd ${S}/../setedit/
	patch -p1 <${FILESDIR}/setedit-${SETEDITVER}.diff || die

	cd ${S}
	patch <${FILESDIR}/rhide-1.4.9-makefile.diff || die
}

src_compile() {

	# Most of these use a _very_ lame build system,
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

	# Fix include problem
	cp ${WORKDIR}/tvision/include/tv/* ${WORKDIR}/tvision/include
	

# ************* SetEdit *************

	cd ${WORKDIR}/setedit/

	./configure --prefix=/usr \
		--fhs \
		--libset || die

	# Fix CFLAGS and CXXFLAGS
	cd ${WORKDIR}/setedit/makes
	cp rhide.env rhide.env.orig
	sed -e "s:${CFLAGS}::g" \
		-e "s:${CXXFLAGS}::g" \
		rhide.env.orig >rhide.env
	make clean || die
	make force-patch || die
	cd ${WORKDIR}/setedit/

	# -j breaks build
	make || die

	# Make the docs
	cd ${WORKDIR}/setedit/doc
	make || die


# ************* RHIDE ***************

	cd ${S}

	# Fix CXXFLAGS
	cp rhide.mak rhide.mak.orig
	sed -e 's:-O2:$(CXXFLAGS):' rhide.mak.orig >rhide.mak
	cp rhide_.mak rhide_.mak.orig
	sed -e 's:-O2:$(CXXFLAGS):' rhide_.mak.orig >rhide_.mak
	cp gpr2mak.mak gpr2mak.mak.orig
	sed -e 's:-O2:$(CXXFLAGS):' gpr2mak.mak.orig >gpr2mak.mak
	cp gprexp.mak gprexp.mak.orig
	sed -e 's:-O2:$(CXXFLAGS):' gprexp.mak.orig >gprexp.mak

	export RHIDESRC="`pwd`"
	export SETSRC="${RHIDESRC}/../setedit"
	export SETOBJ="${RHIDESRC}/../setedit/makes"
	export TVSRC="${RHIDESRC}/../tvision"
	export TVOBJ="${RHIDESRC}/../tvision/linux"

	# -j breaks build
	make prefix=/usr \
		install_docdir=share/doc/${PF} \
		install_infodir=share/info \
		|| die

	# Update and Fix DIR entry in .info files
	cd ${S}/share/setedit/
	sed -e 's:editor.inf:setedit.inf:g' \
		${WORKDIR}/setedit/doc/editor.inf > \
		setedit.inf || die
	sed -e	's:infeng.inf:infview.inf:g' \
		${WORKDIR}/setedit/doc/infeng.inf > \
		infview.inf || die
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
	for file in ${D}/usr/share/info/*.inf ; do
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
