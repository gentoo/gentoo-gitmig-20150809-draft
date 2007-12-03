# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cdf/cdf-3.2.ebuild,v 1.1 2007/12/03 18:41:01 bicatali Exp $

inherit eutils toolchain-funcs multilib

MY_P="${P/-}"
MY_P="${MY_P/.}"

DESCRIPTION="Common Data Format I/O library for multi-dimensional data sets"
HOMEPAGE="http://cdf.gsfc.nasa.gov/"
SRC_BASE="ftp://cdaweb.gsfc.nasa.gov/pub/${PN}/dist/${MY_P}/unix"
SRC_URI="${SRC_BASE}/${MY_P}-dist-${PN}.tar.gz
	java? ( ${SRC_BASE}/${MY_P}-dist-java.tar.gz )
	doc? ( ${SRC_BASE}/${MY_P}_documentation/${MY_P}crm.pdf
		   ${SRC_BASE}/${MY_P}_documentation/${MY_P}frm.pdf
		   ${SRC_BASE}/${MY_P}_documentation/${MY_P}ifd.pdf
		   ${SRC_BASE}/${MY_P}_documentation/${MY_P}prm.pdf
		   ${SRC_BASE}/${MY_P}_documentation/${MY_P}ug.pdf
	java? ( ${SRC_BASE}/${MY_P}_documentation/${MY_P}jrm.pdf ) )"

LICENSE="CDF"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples java ncurses"

RDEPEND="ncurses? ( sys-libs/ncurses )"
DEPEND="${RDEPEND}
		java? ( virtual/jdk	dev-java/java-config )"

S="${WORKDIR}/${MY_P}-dist-readonly"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# respect cflags, remove useless scripts
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-soname.patch
	# use proper lib dir
	sed -i \
		-e "s:\$(INSTALLDIR)/lib:\$(INSTALLDIR)/$(get_libdir):g" \
		Makefile || die "sed failed"
}

src_compile() {
	local myconf
	if use ncurses; then
		myconf="${myconf} CURSES=yes"
	else
		myconf="${myconf} CURSES=no"
	fi
	PV_SO=${PV:0:1}
	emake \
		OS=linux \
		ENV=gnu \
		SHARED=yes \
		SHAREDEXT_linux=so.${PV_SO} \
		${myconf} \
		all || die "emake failed"

	if use java; then
		export CDF_BASE="${S}"
		export CDF_LIB="${S}/src/lib"
		cd cdfjava/jni
		$(tc-getCC) \
			${CFLAGS} -fPIC \
			-I${CDF_BASE}/src/include \
			-I$(java-config -O)/include \
			-I$(java-config -O)/include/linux \
			-c cdfNativeLibrary.c \
			-o cdfNativeLibrary.o \
			|| die "compiling java lib failed"
		$(tc-getLD) \
			-L${CDF_LIB} -lcdf -lm \
			-shared cdfNativeLibrary.o \
			-soname=libcdfNativeLibrary.so.${PV_SO} \
			-o libcdfNativeLibrary.so.${PV_SO} \
			|| die "linking java lib failed"
	fi
}

src_test() {
	emake test || die "test failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/$(get_libdir)
	# -j1 (fragile non-autotooled make)
	emake -j1 \
		INSTALLDIR="${D}usr" \
		SHAREDEXT=so.${PV_SO} \
		install || die "emake install failed"
	dosym libcdf.so.${PV_SO} /usr/$(get_libdir)/libcdf.so

	dodoc Release.notes CHANGES.txt Welcome.txt || die
	doenvd "${FILESDIR}"/50cdf

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/${MY_P}*.pdf
		use java || rm "${D}"/usr/share/doc/${PF}/${MY_P}jrm.pdf
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*
	fi

	if use java; then
		cd cdfjava
		dolib.so jni/libcdfNativeLibrary.so.${PV_SO}
		dosym libcdfNativeLibrary.so.${PV_SO} /usr/$(get_libdir)/libcdfNativeLibrary.so
		insinto /usr/share/cdf
		doins */*.jar
		if use examples; then
			insinto /usr/share/doc/${PF}/examples/java
			doins examples/*
		fi
	fi

}
