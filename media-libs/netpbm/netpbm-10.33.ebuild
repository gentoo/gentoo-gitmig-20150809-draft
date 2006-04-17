# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-10.33.ebuild,v 1.3 2006/04/17 00:12:53 flameeyes Exp $

inherit flag-o-matic toolchain-funcs eutils multilib

MAN_VER=10.33
DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
HOMEPAGE="http://netpbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
	mirror://gentoo/${PN}-${MAN_VER}-manpages.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="svga jpeg tiff png zlib"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.5 )
	png? ( >=media-libs/libpng-1.2.1 )
	zlib? ( sys-libs/zlib )
	svga? ( media-libs/svgalib )
	media-libs/jbigkit
	media-libs/jasper
	media-libs/urt"

netpbm_libtype() {
	case ${CHOST} in
		*-darwin*) echo dylib;;
		*)         echo unixshared;;
	esac
}
netpbm_libsuffix() {
	local suffix=$(get_libname)
	echo ${suffix//\.}
}
netpbm_ldshlib() {
	case ${CHOST} in
		*-darwin*) echo '$(LDFLAGS) -dynamiclib -install_name $(SONAME)';;
		*)         echo '$(LDFLAGS) -shared -Wl,-soname,$(SONAME)';;
	esac
}
netpbm_config() {
	use $1 && echo -l${2:-$1} || echo NONE
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/netpbm-10.31-build.patch
	epatch "${FILESDIR}"/netpbm-10.33-lib-objs.patch
	epatch "${FILESDIR}/${P}-memmem.patch"

	rm -f configure
	cp Makefile.config.in Makefile.config
	cat >> Makefile.config <<-EOF
	# Gentoo toolchain options
	CC = $(tc-getCC) -Wall
	CC_FOR_BUILD = $(tc-getBUILD_CC)
	AR = $(tc-getAR)
	RANLIB = $(tc-getRANLIB)
	STRIPFLAG =
	CFLAGS_SHLIB = -fPIC

	NETPBMLIBTYPE = $(netpbm_libtype)
	NETPBMLIBSUFFIX = $(netpbm_libsuffix)
	LDSHLIB = $(netpbm_ldshlib)

	# Gentoo build options
	TIFFLIB = $(netpbm_config tiff)
	JPEGLIB = $(netpbm_config jpeg)
	PNGLIB = $(netpbm_config png)
	ZLIB = $(netpbm_config zlib z)
	LINUXSVGALIB = $(netpbm_config svga vga)

	# Use system versions instead of bundled
	JBIGLIB = -ljbig
	JBIGHDR_DIR =
	JASPERLIB = -ljasper
	JASPERHDR_DIR =
	URTLIB = -lrle
	URTHDR_DIR =
	EOF
}

src_compile() {
	replace-flags -mcpu=ultrasparc "-mcpu=v8 -mtune=ultrasparc"
	replace-flags -mcpu=v9 "-mcpu=v8 -mtune=v9"

	emake || die
}

src_install() {
	make package pkgdir="${D}"/usr || die "make package failed"

	[[ $(get_libdir) != "lib" ]] && mv "${D}"/usr/lib "${D}"/usr/$(get_libdir)

	# Remove cruft that we don't need, and move around stuff we want
	rm -f "${D}"/usr/bin/{doc.url,manweb}
	rm -rf "${D}"/usr/man/web
	rm -rf "${D}"/usr/link
	rm -f "${D}"/usr/{README,VERSION,config_template,pkginfo}
	dodir /usr/share
	mv "${D}"/usr/man "${D}"/usr/share/
	mv "${D}"/usr/misc "${D}"/usr/share/netpbm

	dodoc README
	cd doc
	GLOBIGNORE='*.html:.*' dodoc *
	dohtml -r .

	cd "${WORKDIR}"/${PN}-${MAN_VER}-manpages || die
	doman *.[0-9]
	dodoc README* gen-netpbm-manpages
}
