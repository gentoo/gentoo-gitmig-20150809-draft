# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ploticus/ploticus-2.33-r1.ebuild,v 1.1 2007/08/28 21:45:54 dragonheart Exp $

inherit eutils toolchain-funcs

MY_P=pl${PV/.}src

S=${WORKDIR}/${MY_P}
DESCRIPTION="A command line application for producing graphs and charts"
HOMEPAGE="http://ploticus.sourceforge.net"
SRC_URI="mirror://sourceforge/ploticus/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gd flash nls cpulimit svg svgz truetype X"
DEPEND="media-libs/libpng
	gd? ( >=media-libs/gd-1.84 media-libs/jpeg )
	flash? ( =media-libs/ming-0.2a )
	truetype? ( =media-libs/freetype-2* )
	X? ( x11-libs/libX11 )"

pkg_setup() {
	if use gd;
	then
		if ! built_with_use media-libs/gd jpeg || ! built_with_use media-libs/gd png; then
			die "media-libs/gd needs to be build with USE=\"png jpeg\""
		fi
	fi
}
src_unpack() {
	unpack ${A}
	# Fixes a problem with NOX11.
	# Changes the install directory and comments all flash and gd-related
	# options. (These options will be selectively uncommented later.)
	epatch ${FILESDIR}/${MY_P}.patch
}

src_compile() {
	cd src
	# ploticus may be compiled using the external libgd, a libgd provided with
	# the package, or no gd support at all.

	local MO=""
	if useq gd; then
		# PNG and JPEG are supported by default.
		GD18LIBS="-lgd -lpng -lz -ljpeg"
		# Note that truetype works only with the external gd lib.
		if useq truetype; then
			GD18LIBS="${GD18LIBS} -lfreetype"
			MO="${MO} GDFREETYPE=-DGDFREETYPE"
		fi
		# Set the graphics formats support.
		# Use the external libgd.
		MO="${MO} ZFLAG=-DWZ GD18H= GD16H= GDLEVEL=-DGD18=1 plgd18"
		EXE="plpng"
		GD16LIBS="${GD18LIBS}"
		GD18LIBS="${GD18LIBS}"

	else
		# No support for libgd at all.
		# Note that gif and truetype do not work without gd.
		EXE=plnogd
		MO="${MO} NOGDFLAG=-DNOGD"
		GD16LIBS=
		GD18LIBS=
	fi

	# Support for non-roman alphabets and collation.
	if useq nls; then
		MO="${MO} LOCALEOBJ=localef.o LOCALE_FLAG=-DLOCALE"
	fi

	# Support for compressed or uncompressed svg. svgz implies svg. If the
	# external gd library is used, the svgz format will always be available if
	# ploticus was compiled with support for svg (even if the svgz flag was not
	# specified and even if the -svgz flag was used).
	if useq svgz; then
		MO="${MO} ZLIB=-lz ZFLAG=-DWZ"
	elif ! useq svg; then
		MO="${MO} NOSVGFLAG=-DNOSVG"
	fi

	# Support for X11 output.
	if ! useq X; then
		MO="${MO} NOXFLAG=-DNOX11 XLIBS= XOBJ="
	fi

	# Support for Flash output.
	if useq flash; then
		MO="${MO} MING=-lming"
	else
		MO="${MO} NOSWFFLAG=-DNOSWF"
	fi

	# Support for limiting CPU utilization. (Enabled by default.)
	if ! useq cpulimit; then
		MO="${MO} NORLIMFLAG=-DNORLIMIT"
	fi
	emake "CC=$(tc-getCC)" ${MO} EXE="${EXE}" GD18LIBS="${GD18LIBS}" \
		GD16LIBS="${GD16LIBS}" \
		PREFABS_DIR=/usr/share/ploticus/prefabs ploticus || die

	einfo "Compiling C API library"

	emake "CC=$(tc-getCC)" \
	-f Makefile_api || die "API make failed!"
}

src_test() {
	cd ${S}/pltestsuite
	export PATH="${S}/src:${PATH}"
	#sed -i -e "s:PL=.*:PL=${S}/src/pl:" run_script_test
	local TESTS="gif png jpeg eps"
	useq svg && TESTS="${TESTS} svg"
	useq svgz && TESTS="${TESTS} svgz"
	for TEST in ${TESTS};
	do
		echo "Testing ${TEST}"
		echo -e "${TEST}\n" | ./run_script_test
		cat Diag.out
	done
}

src_install() {
	dodoc README
	cd ${S}/src
	mkdir -p ${D}usr/bin
	if useq gd; then
		EXE="pl plpng"
	else
		EXE=pl
	fi
	emake DESTDIR=${D} EXE="${EXE}" install || die

	dolib ${S}/src/libploticus.a

	PL_TARGET=/usr/share/${PN}
	insinto ${PL_TARGET}/prefabs
	doins ${S}/prefabs/*
	insinto ${PL_TARGET}/testsuite
	doins ${S}/pltestsuite/*
}
