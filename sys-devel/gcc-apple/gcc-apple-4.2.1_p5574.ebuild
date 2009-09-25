# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-apple/gcc-apple-4.2.1_p5574.ebuild,v 1.3 2009/09/25 17:38:57 mr_bones_ Exp $

ETYPE="gcc-compiler"

inherit eutils toolchain flag-o-matic autotools prefix

GCC_VERS=${PV/_p*/}
APPLE_VERS=${PV/*_p/}
LIBSTDCXX_APPLE_VERSION=16
DESCRIPTION="Apple branch of the GNU Compiler Collection, Developer Tools 3.1.3"
HOMEPAGE="http://gcc.gnu.org"
SRC_URI="http://www.opensource.apple.com/darwinsource/tarballs/other/gcc_42-${APPLE_VERS}.tar.gz
		http://www.opensource.apple.com/darwinsource/tarballs/other/libstdcxx-${LIBSTDCXX_APPLE_VERSION}.tar.gz
		fortran? ( mirror://gnu/gcc/gcc-${GCC_VERS}/gcc-fortran-${GCC_VERS}.tar.bz2 )"
LICENSE="APSL-2 GPL-2"

if is_crosscompile; then
	SLOT="${CTARGET}-42"
else
	SLOT="42"
fi

KEYWORDS="~ppc-macos ~x64-macos ~x86-macos"

IUSE="fortran nls objc objc++ nocxx"

RDEPEND=">=sys-libs/zlib-1.1.4
	>=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )
	>=sys-devel/gcc-config-1.3.12-r4
	fortran? (
		>=dev-libs/gmp-4.2.1
		>=dev-libs/mpfr-2.2.0_p10
	)"
DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	${CATEGORY}/binutils-apple
	>=dev-libs/mpfr-2.2.0_p10"

S=${WORKDIR}/gcc_42-${APPLE_VERS}

# TPREFIX is the prefix of the CTARGET installation
export TPREFIX=${TPREFIX:-${EPREFIX}}

LIBPATH=${EPREFIX}/usr/lib/gcc/${CTARGET}/${GCC_VERS}
if is_crosscompile ; then
	BINPATH=${EPREFIX}/usr/${CHOST}/${CTARGET}/gcc-bin/${GCC_VERS}
else
	BINPATH=${EPREFIX}/usr/${CTARGET}/gcc-bin/${GCC_VERS}
fi
STDCXX_INCDIR=${LIBPATH}/include/g++-v${GCC_VERS/\.*/}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Support for fortran
	if use fortran ; then
		cd "${WORKDIR}"/gcc-${GCC_VERS}
		# hmmm, just use rsync?
		tar cf - * | ( cd "${S}" && tar xf - )
		cd "${S}"
		# from: http://r.research.att.com/tools/
		epatch "${FILESDIR}"/${PN}-${GCC_VERS}-gfortran.patch
	fi

	# we use our libtool
	sed -i -e "s:/usr/bin/libtool:${EPREFIX}/usr/bin/${CTARGET}-libtool:" \
		gcc/config/darwin.h || die "sed gcc/config/darwin.h failed"
	# add prefixed Frameworks to default search paths (may want to change this
	# in a cross-compile)
	sed -i -e "/\"\/System\/Library\/Frameworks\"\,/i\ \   \"${EPREFIX}/Frameworks\"\, " \
		gcc/config/darwin-c.c || die "sed  gcc/config/darwin-c.c failed"

	# Workaround deprecated "+Nc" syntax for GNU tail(1)
	sed -i -e "s:tail +16c:tail -c +16:g" \
		gcc/Makefile.in || die "sed gcc/Makefile.in failed."

	epatch "${FILESDIR}"/${PN}-4.0.1_p5465-default-altivec.patch
	epatch "${FILESDIR}"/${PN}-4.2.1_p5566-x86_64-defines.patch

	# dsymutil stuff breaks on 10.4/x86, revert it
	[[ ${CHOST} == *86*-apple-darwin8 ]] && \
		epatch "${FILESDIR}"/${PN}-${GCC_VERS}-dsymutil.patch

	# bootstrapping might fail with host provided gcc on 10.4/x86
	if ! is_crosscompile && ! echo "int main(){return 0;}" | gcc -o "${T}"/foo \
		-mdynamic-no-pic -x c - >/dev/null 2>&1;
	then
		einfo "-mdynamic-no-pic doesn't work - disabling..."
		echo "BOOT_CFLAGS=-g -O2" > config/mh-x86-darwin
		XD=gcc/config/i386/x-darwin
		awk 'BEGIN{x=1}{if ($0 ~ "use -mdynamic-no-pic to build x86")
		{x=1-x} else if (x) print}' $XD > t && mv t $XD \
			|| die "Failed to rewrite $XD"
	fi

	epatch "${FILESDIR}"/${PN}-4.2.1-prefix-search-dirs.patch
	eprefixify "${S}"/gcc/gcc.c

	epatch "${FILESDIR}"/${PN}-${GCC_VERS}-texinfo.patch
	cd "${S}"/gcc && eautoconf
	cd "${S}"/libgomp && eautoconf

	cd "${WORKDIR}"/libstdcxx-${LIBSTDCXX_APPLE_VERSION}/libstdcxx
	epatch "${FILESDIR}"/libstdc++-${LIBSTDCXX_APPLE_VERSION}.patch
	# copy lt-stuff that has been fixed for darwin10 in gcc but not
	# libstdcxx
	cp "${S}"/lt* . || die "failed to update libstdcxx' lt-files"

	# until this is tested not to break on earlier versions, apply it
	# conditionally
	[[ ${CHOST} == *-darwin10 ]] && \
		epatch "${FILESDIR}"/${PN}-4.2.1_p5574-darwin10.patch
}

src_compile() {
	local langs="c"
	use nocxx || langs="${langs},c++"
	use objc && langs="${langs},objc"
	use objc++ && langs="${langs/,objc/},objc,obj-c++" # need objc with objc++
	use fortran && langs="${langs},fortran"

	local myconf="${myconf} \
		--prefix=${EPREFIX}/usr \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
		--datadir=${EPREFIX}/usr/share/gcc-data/${CTARGET}/${GCC_VERS} \
		--mandir=${EPREFIX}/usr/share/gcc-data/${CTARGET}/${GCC_VERS}/man \
		--infodir=${EPREFIX}/usr/share/gcc-data/${CTARGET}/${GCC_VERS}/info \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--host=${CHOST}
		--enable-version-specific-runtime-libs"

	if is_crosscompile ; then
		# Straight from the GCC install doc:
		# "GCC has code to correctly determine the correct value for target
		# for nearly all native systems. Therefore, we highly recommend you
		# not provide a configure target when configuring a native compiler."
		myconf="${myconf} --target=${CTARGET}"

		# Tell compiler where to find what it needs
		myconf="${myconf} --with-sysroot=${EPREFIX}/usr/${CTARGET}"

		# Set this to something sane for both native and target
		CFLAGS="-O2 -pipe"

		local VAR="CFLAGS_"${CTARGET//-/_}
		CXXFLAGS=${!VAR}
	fi
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"

	# Native Language Support
	if use nls ; then
		myconf="${myconf} --enable-nls --without-included-gettext"
	else
		myconf="${myconf} --disable-nls"
	fi

	# reasonably sane globals (hopefully)
	myconf="${myconf} \
		--with-system-zlib \
		--disable-checking \
		--disable-werror"

	# ???
	myconf="${myconf} --enable-shared --enable-threads=posix"

	# make clear we're in an offset
	use prefix && myconf="${myconf} --with-local-prefix=${TPREFIX}/usr"

	# we don't use a GNU linker, so tell GCC where to find the linker stuff we
	# want it to use
	myconf="${myconf} \
		--with-as=${EPREFIX}/usr/bin/${CTARGET}-as \
		--with-ld=${EPREFIX}/usr/bin/${CTARGET}-ld"

	# make sure we never do multilib stuff, for that we need a different Prefix
	[[ -z ${I_KNOW_WHAT_IM_DOING_I_WANT_APPLE_MULTILIB} ]] \
		&& myconf="${myconf} --disable-multilib"

	#libstdcxx does not support this one
	local gccconf="${myconf} --enable-languages=${langs}"

	# The produced libgcc_s.dylib is faulty if using a bit too much
	# optimisation.  Nail it down to something sane
	CFLAGS="-O2 -pipe"
	CXXFLAGS=${CFLAGS}

	# http://gcc.gnu.org/ml/gcc-patches/2006-11/msg00765.html
	# (won't hurt if already 64-bits, but is essential when coming from a
	# multilib compiler -- the default)
	[[ ${CTARGET} == powerpc64-* || ${CTARGET} == x86_64-* ]] && \
		export CC="gcc -m64"

	mkdir -p "${WORKDIR}"/build
	cd "${WORKDIR}"/build
	einfo "Configuring GCC with: ${gccconf//--/\n\t--}"
	"${S}"/configure ${gccconf} || die "conf failed"
	emake bootstrap || die "emake failed"

	local libstdcxxconf="${myconf} --disable-libstdcxx-debug"
	mkdir -p "${WORKDIR}"/build_libstdcxx || die
	cd "${WORKDIR}"/build_libstdcxx
	#the build requires the gcc built before, so link to it
	ln -s "${WORKDIR}"/build/gcc "${WORKDIR}"/build_libstdcxx/gcc || die
	einfo "Configuring libstdcxx with: ${libstdcxxconf//--/\n\t--}"
	"${WORKDIR}"/libstdcxx-${LIBSTDCXX_APPLE_VERSION}/libstdcxx/configure ${libstdcxxconf} || die "conf failed"
	emake all || die "emake failed"
}

src_install() {
	local ED=${ED-${D}}

	cd "${WORKDIR}"/build
	# -jX doesn't work
	emake -j1 DESTDIR="${D}" install || die

	cd "${WORKDIR}"/build_libstdcxx
	emake -j1 DESTDIR="${D}" install || die
	cd "${WORKDIR}"/build

	# Punt some tools which are really only useful while building gcc
	find "${ED}" -name install-tools -prune -type d -exec rm -rf "{}" \;
	# This one comes with binutils
	find "${ED}" -name libiberty.a -exec rm -f "{}" \;

	# Basic sanity check
	if ! is_crosscompile ; then
		local EXEEXT
		eval $(grep ^EXEEXT= "${WORKDIR}"/build/gcc/config.log)
		[[ -r ${D}${BINPATH}/gcc${EXEEXT} ]] || die "gcc not found in ${ED}"
	fi

	# create gcc-config entry
	dodir /etc/env.d/gcc
	local gcc_envd_base="/etc/env.d/gcc/${CHOST}-${GCC_VERS}"

	gcc_envd_file="${ED}${gcc_envd_base}"

	# phase PATH/ROOTPATH out ...
	echo "PATH=\"${BINPATH}\"" > ${gcc_envd_file}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${gcc_envd_file}
	echo "GCC_PATH=\"${BINPATH}\"" >> ${gcc_envd_file}

	# we don't do multilib
	LDPATH="${LIBPATH}"
	echo "LDPATH=\"${LDPATH}\"" >> ${gcc_envd_file}
	echo "MANPATH=\"${EPREFIX}/usr/share/gcc-data/${CHOST}/${GCC_VERS}/man\"" >> ${gcc_envd_file}
	echo "INFOPATH=\"${EPREFIX}/usr/share/gcc-data/${CHOST}/${GCC_VERS}/info\"" >> ${gcc_envd_file}
	echo "STDCXX_INCDIR=\"g++-v${GCC_VERS/\.*/}\"" >> ${gcc_envd_file}
	is_crosscompile && echo "CTARGET=${CTARGET}" >> ${gcc_envd_file}

	# Move <cxxabi.h> to compiler-specific directories
	[[ -f ${D}${STDCXX_INCDIR}/cxxabi.h ]] && \
		mv -f "${D}"${STDCXX_INCDIR}/cxxabi.h "${D}"${LIBPATH}/include/

	# These should be symlinks
	dodir /usr/bin
	cd "${D}"${BINPATH}
	for x in cpp gcc g++ c++ g77 gcj gcjh gfortran ; do
		# For some reason, g77 gets made instead of ${CTARGET}-g77...
		# this should take care of that
		[[ -f ${x} ]] && mv ${x} ${CTARGET}-${x}

		if [[ -f ${CTARGET}-${x} ]] && ! is_crosscompile ; then
			ln -sf ${CTARGET}-${x} ${x}

			# Create version-ed symlinks
			dosym ${BINPATH#${EPREFIX}}/${CTARGET}-${x} \
				/usr/bin/${CTARGET}-${x}-${GCC_VERS}
			dosym ${BINPATH#${EPREFIX}}/${CTARGET}-${x} \
				/usr/bin/${x}-${GCC_VERS}
		fi

		if [[ -f ${CTARGET}-${x}-${GCC_VERS} ]] ; then
			rm -f ${CTARGET}-${x}-${GCC_VERS}
			ln -sf ${CTARGET}-${x} ${CTARGET}-${x}-${GCC_VERS}
		fi
	done

	# I do not know if this will break gcj stuff, so I'll only do it for
	#	objc for now; basically "ffi.h" is the correct file to include,
	#	but it gets installed in .../GCCVER/include and yet it does
	#	"#include <ffitarget.h>" which (correctly, as it's an "extra" file)
	#	is installed in .../GCCVER/include/libffi; the following fixes
	#	ffi.'s include of ffitarget.h - Armando Di Cianno <fafhrd@gentoo.org>
	if [[ -d ${D}${LIBPATH}/include/libffi ]] ; then
		mv -i "${D}"${LIBPATH}/include/libffi/* "${D}"${LIBPATH}/include || die
		rm -r "${D}"${LIBPATH}/include/libffi || die
	fi

	# Now do the fun stripping stuff
	env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${BINPATH}"
	env RESTRICT="" CHOST=${CTARGET} prepstrip "${D}${LIBPATH}"
	# gcc used to install helper binaries in lib/ but then moved to libexec/
	[[ -d ${ED}/usr/libexec/gcc ]] && \
		env RESTRICT="" CHOST=${CHOST} prepstrip "${ED}/usr/libexec/gcc/${CTARGET}/${GCC_VERS}"

	# prune empty dirs left behind
	find "${ED}" -type d | xargs rmdir >& /dev/null
}

pkg_postinst() {
	# beware this also switches when it's on another branch version of GCC
	gcc-config ${CTARGET}-${GCC_VERS}
}

pkg_postrm() {
	local EROOT=${EROOT-${ROOT}}

	# clean up the cruft left behind by cross-compilers
	if is_crosscompile ; then
		if [[ -z $(ls "${EROOT}"/etc/env.d/gcc/${CTARGET}* 2>/dev/null) ]] ; then
			rm -f "${EROOT}"/etc/env.d/gcc/config-${CTARGET}
			rm -f "${EROOT}"/etc/env.d/??gcc-${CTARGET}
			rm -f "${EROOT}"/usr/bin/${CTARGET}-{gcc,{g,c}++}{,32,64}
		fi
		return 0
	fi
}
