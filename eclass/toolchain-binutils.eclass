# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/toolchain-binutils.eclass,v 1.31 2005/03/24 03:04:47 vapier Exp $

# We install binutils into CTARGET-VERSION specific directories.  This lets 
# us easily merge multiple versions for multiple targets (if we wish) and 
# then switch the versions on the fly (with `binutils-config`).

inherit eutils libtool flag-o-matic gnuconfig
ECLASS=toolchain-binutils
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_unpack src_compile src_test src_install pkg_postinst pkg_postrm

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="Tools necessary to build programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2"
[[ -n ${PATCHVER} ]] && \
	SRC_URI="${SRC_URI} mirror://gentoo/${P}-patches-${PATCHVER}.tar.bz2"
[[ -n ${UCLIBC_PATCHVER} ]] && \
	SRC_URI="${SRC_URI} mirror://gentoo/${P}-uclibc-patches-${UCLIBC_PATCHVER}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2 )"
IUSE="nls multitarget multislot test"
if use multislot ; then
	SLOT="${CTARGET}-${PV}"
elif [[ ${CTARGET} != ${CHOST} ]] ; then
	SLOT="${CTARGET}"
else
	SLOT="0"
fi

RDEPEND="virtual/libc
	>=sys-devel/binutils-config-1.3"
DEPEND="${RDEPEND}
	test? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

LIBPATH=/usr/$(get_libdir)/binutils/${CTARGET}/${PV}
INCPATH=${LIBPATH}/include
BINPATH=/usr/${CTARGET}/binutils-bin/${PV}
DATAPATH=/usr/share/binutils-data/${CTARGET}/${PV}
MY_BUILDDIR=${WORKDIR}/build

is_cross() { [[ ${CHOST} != ${CTARGET} ]] ; }

toolchain-binutils_src_unpack() {
	unpack ${A}
	mkdir -p "${MY_BUILDDIR}"
}

apply_binutils_updates() {
	cd "${S}"

	[[ -n ${PATCHVER} ]] && epatch "${WORKDIR}"/patch
	if [[ -n ${UCLIBC_PATCHVER} ]] ; then
		epatch "${WORKDIR}"/uclibc-patches
	elif [[ ${CTARGET} == *-uclibc ]] ; then
		die "sorry, but this binutils doesn't yet support uClibc :("
	fi

	# Fix po Makefile generators
	sed -i \
		-e '/^datadir = /s:$(prefix)/@DATADIRNAME@:@datadir@:' \
		-e '/^gnulocaledir = /s:$(prefix)/share:$(datadir):' \
		*/po/Make-in || die "sed po's failed"

	# Run misc portage update scripts
	gnuconfig_update
	elibtoolize --portage --no-uclibc

	# make sure we filter $LINGUAS so that only ones that
	# actually work with all the subdirs make it through
	strip-linguas -i */po
}

toolchain-binutils_src_compile() {
	strip-flags && replace-flags -O3 -O2 #47581

	cd "${MY_BUILDDIR}"
	local myconf=""
	use nls \
		&& myconf="${myconf} --without-included-gettext" \
		|| myconf="${myconf} --disable-nls"
	use multitarget && myconf="${myconf} --enable-targets=all"
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"
	myconf="--prefix=/usr \
		--host=${CHOST} \
		--target=${CTARGET} \
		--datadir=${DATAPATH} \
		--infodir=${DATAPATH}/info \
		--mandir=${DATAPATH}/man \
		--bindir=${BINPATH} \
		--libdir=${LIBPATH} \
		--libexecdir=${LIBPATH} \
		--includedir=${INCPATH} \
		--enable-shared \
		--enable-64-bit-bfd \
		${myconf} ${EXTRA_ECONF}"
	echo ./configure ${myconf}
	"${S}"/configure ${myconf} || die "configure failed"

	# binutils' build system is a bit broken with internal
	# dependencies, so we manually run these first two bfd
	# targets so that we can than use -j# and have it work
	emake -j1 configure-bfd || die "make configure-bfd failed"
	emake -j1 headers -C bfd || die "make headers-bfd failed"
	emake all || die "emake failed"

	# only build info pages if we user wants them, and if 
	# we have makeinfo (may not exist when we bootstrap)
	if ! has noinfo ${FEATURES} ; then
		if type -p makeinfo ; then
			make info || die "make info failed"
		fi
	fi
	# we nuke the manpages when we're left with junk 
	# (like when we bootstrap, no perl -> no manpages)
	find . -name '*.1' -a -size 0 | xargs rm -f
}

toolchain-binutils_src_test() {
	cd "${MY_BUILDDIR}"
	make check || die "check failed :("
}

toolchain-binutils_src_install() {
	local x d

	cd "${MY_BUILDDIR}"
	make DESTDIR="${D}" tooldir="${LIBPATH}" install || die
	rm -rf "${D}"/${LIBPATH}/bin

	# Now we collect everything intp the proper SLOT-ed dirs
	# When something is built to cross-compile, it installs into
	# /usr/$CHOST/ by default ... we have to 'fix' that :)
	if is_cross ; then
		cd "${D}"/${BINPATH}
		for x in * ; do
			mv ${x} ${x/${CTARGET}-}
		done

		mv "${D}"/usr/${CHOST}/${CTARGET}/include "${D}"/${INCPATH}
		mv "${D}"/usr/${CHOST}/${CTARGET}/lib/* "${D}"/${LIBPATH}/
		rm -r "${D}"/usr/${CHOST}
	else
		insinto ${INCPATH}
		doins "${S}/include/libiberty.h"
	fi
	if [[ -d ${D}/${LIBPATH}/lib ]] ; then
		mv "${D}"/${LIBPATH}/lib/* "${D}"/${LIBPATH}/
		rm -r "${D}"/${LIBPATH}/lib
	fi
	dodir /usr/${CTARGET}/{bin,include,lib}
	prepman ${DATAPATH}

	# Now, some binutils are tricky and actually provide 
	# for multiple TARGETS.  Really, we're talking just 
	# 32bit/64bit support (like mips/ppc/sparc).  Here 
	# we want to tell binutils-config that it's cool if 
	# it generates multiple sets of binutil symlinks.
	# e.g. sparc gets {sparc,sparc64}-unknown-linux-gnu
	local targ=${CTARGET/-*}
	local FAKE_TARGETS=${CTARGET}
	case ${targ} in
		mips64*|powerpc64|sparc64*)
			FAKE_TARGETS="${FAKE_TARGETS} ${CTARGET/64-/-}";;
		mips*|powerpc|sparc*)
			FAKE_TARGETS="${FAKE_TARGETS} ${CTARGET/-/64-}";;
	esac
	

	# Generate an env.d entry for this binutils
	cd "${S}"
	insinto /etc/env.d/binutils
	cat <<-EOF > env.d
		TARGET="${CTARGET}"
		VER="${PV}"
		LIBPATH="${LIBPATH}"
		FAKE_TARGETS="${FAKE_TARGETS}"
	EOF
	newins env.d ${CTARGET}-${PV}

	# Handle documentation
	if ! is_cross ; then
		cd "${S}"
		dodoc README
		docinto bfd
		dodoc bfd/ChangeLog* bfd/README bfd/PORTING bfd/TODO
		docinto binutils
		dodoc binutils/ChangeLog binutils/NEWS binutils/README
		docinto gas
		dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/NEWS gas/README*
		docinto gprof
		dodoc gprof/ChangeLog* gprof/TEST gprof/TODO gprof/bbconv.pl
		docinto ld
		dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
		docinto libiberty
		dodoc libiberty/ChangeLog* libiberty/README
		docinto opcodes
		dodoc opcodes/ChangeLog*
	fi
	# Punt all the fun stuff if user doesn't want it :)
	has noinfo ${FEATURES} && rm -r "${D}"/${DATAPATH}/info
	has noman ${FEATURES} && rm -r "${D}"/${DATAPATH}/man
}

toolchain-binutils_pkg_postinst() {
	# Make sure this ${CTARGET} has a binutils version selected
	[[ -e ${ROOT}/etc/env.d/binutils/config-${CTARGET} ]] && return 0
	binutils-config ${CTARGET}-${PV}
}

toolchain-binutils_pkg_postrm() {
	local choice=$(binutils-config -l | grep ${CTARGET} | grep -v ${CTARGET}-${PV})
	choice=${choice/* }

	# If no other versions exist, then uninstall for this 
	# target ... otherwise, switch to the newest version
	# Note: only do this if this version is unmerged.  We
	#       rerun binutils-config if this is a remerge, as
	#       we want the mtimes on the symlinks updated (if
	#       it is the same as the current selected profile)
	if [[ ! -e ${BINPATH}/ld ]] ; then
		if [[ -z ${choice} ]] ; then
			binutils-config -u ${CTARGET}
		else
			binutils-config ${choice}
		fi
	elif [[ $(CHOST=${CTARGET} binutils-config -c) == ${CTARGET}-${PV} ]] ; then
		binutils-config ${CTARGET}-${PV}
	fi
}
