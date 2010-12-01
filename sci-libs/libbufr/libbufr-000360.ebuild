# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libbufr/libbufr-000360.ebuild,v 1.3 2010/12/01 16:59:04 bicatali Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_P="${PN/lib/}_${PV}"

DESCRIPTION="ECMWF BUFR library - includes both C and Fortran example utilities."
HOMEPAGE="http://www.ecmwf.int/products/data/software/bufr.html"
SRC_URI="http://www.ecmwf.int/products/data/software/download/software_files/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# needs someone to test on these: ~alpha ~hppa ~ia64 ~ppc ~ppc64 ~sparc etc ...

IUSE="doc examples"

RDEPEND=""

DEPEND="sys-apps/findutils"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	case "$(tc-getFC)" in
		*gfortran)
			export CNAME="_gfortran"
			;;
		*g77)
			export CNAME="_gnu"
			;;
		*pgf90|*pgf77)
			export CNAME="_linux"
			;;
		ifc|ifort)
			export CNAME="_intel"
			;;
	esac

	export target="linux"
	case "${ARCH}" in
		amd64|ppc64)
			export A64="A64"
			export R64="R64"
			;;
		ia64)
			export A64=""
			export R64="R64"
			export target="itanium"
			;;
		hppa)
			export target="hppa"
			export R64=""
			;;
		*)
			export A64=""
			export R64=""
			;;
	esac
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type f | xargs chmod -x
	chmod +x bufrtables/links.sh
	if use debug ; then
		sed -i -e "s:-O2:-g ${CFLAGS}:g" \
			config/config.$target$CNAME$R64$A64
	else
		sed -i -e "s:-O2:${CFLAGS}:g" \
			config/config.$target$CNAME$R64$A64
	fi
}

src_compile() {
	EBUILD_ARCH="${ARCH}"
	EBUILD_CFLAGS="${CFLAGS}"
	unset ARCH CFLAGS
	tc-export
	append-flags -DTABLE_PATH="/usr/share/bufrtables"

	make ARCH=linux || die "make failed"

	ARCH="${EBUILD_ARCH}"
	CFLAGS="${EBUILD_CFLAGS}"

	generate_files

	cd "${S}"/examples
	make ARCH=linux decode_bufr bufr_decode create_bufr \
		decode_bufr_image tdexp || die "make examples failed"
}

src_test() {
	cd "${S}"/examples
	BUFR_TABLES="${S}/bufrtables/" ./decode_bufr -i \
		../data/ISMD01_OKPR.bufr < ../response_file
}

src_install() {
	dolib.a libbufrR64.a
	dosbin bufrtables/{bufr2txt_tables,bufr_split_tables,txt2bufr_tables}
	dobin examples/{create_bufr,decode_bufr,decode_bufr_image}

	keepdir /usr/share/bufrtables
	insinto /usr/share/bufrtables
	doins bufrtables/*000*

	# files generated above
	doenvd 20${PN}

	dodoc README
	if use doc ; then
		insinto /usr/share/doc/${P}
		doins doc/*.pdf
	fi

	if use examples ; then
		newdoc examples/README README.examples
		insinto /usr/share/doc/${P}/examples
		doins examples/{*.F,*.c,Makefile}
	fi
}

pkg_postinst() {
	elog
	elog "This is the only GPL'd BUFR decoder library written in C/Fortran"
	elog "but the build system is an old kluge that pre-dates the discovery"
	elog "of fire.  File bugs as usual if you have build/runtime problems."
	elog ""
	elog "The default BUFR tables are stored in /usr/share/bufrtables, so"
	elog "add your local tables there if needed.  Only a static lib is"
	elog "installed currently, as shared lib support is incomplete (feel"
	elog "free to submit a patch :)"
	elog ""
	elog "The installed user-land bufr utilities are just the examples;"
	elog "the main library is really all there is (and there are no man"
	elog "pages either).  Install the examples and use the source, Luke..."
	elog
}

generate_files() {
	cat <<-EOF > 20${PN}
	BUFR_TABLES="/usr/share/bufrtables"
	CONFIG_PROTECT="/usr/share/bufrtables"
	EOF

	cat <<-EOF > response_file
	N
	N
	N

	Y
	EOF
}
