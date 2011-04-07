# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/llvm-gcc/llvm-gcc-2.9.ebuild,v 1.1 2011/04/07 09:56:13 voyageur Exp $

EAPI=3
inherit libtool flag-o-matic gnuconfig multilib

LLVM_GCC_VERSION=4.2
MY_PV=${LLVM_GCC_VERSION}-${PV/_pre*}

DESCRIPTION="LLVM C front-end"
HOMEPAGE="http://llvm.org"
SRC_URI="http://llvm.org/releases/${PV}/${PN}-${MY_PV}.source.tgz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos"
IUSE="bootstrap fortran multilib nls objc objc++ test"

RDEPEND=">=sys-devel/llvm-$PV"
DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	|| ( >=sys-devel/binutils-2.18 >=sys-devel/binutils-apple-3.2.3 )
	>=sys-devel/bison-1.875
	test? ( dev-util/dejagnu
		sys-devel/autogen )"

S=${WORKDIR}/llvm-gcc-${MY_PV}.source

src_prepare() {
	#we keep the directory structure suggested by README.LLVM,
	mkdir -p "${S}"/obj

	# From toolchain eclass
	elibtoolize --portage --shallow --no-uclibc
	gnuconfig_update

	# update configure files
	local f
	for f in $(grep -l 'autoconf version 2.13' $(find "${S}" -name configure)) ; do
		#ebegin "  Updating ${f/${S}\/} [LANG]"
		ebegin "  Updating \"${f/${S}\/}\" [LANG]"
		patch "${f}" "${FILESDIR}"/gcc-configure-LANG.patch >& "${T}"/configure-patch.log \
			|| eerror "Please file a bug about this"
		eend $?
	done
	sed -i 's|A-Za-z0-9|[:alnum:]|g' gcc/*.awk #215828

	if [[ -x contrib/gcc_update ]] ; then
		einfo "Touching generated files"
		./contrib/gcc_update --touch | \
			while read f ; do
				einfo "  ${f%%...}"
			done
	fi
}

src_configure() {
	gcc_do_filter_flags
	# Target options are handled by econf

	cd "${S}"/obj
	EXTRALANGS=""
	use fortran && EXTRALANGS="${EXTRALANGS},fortran"
	use objc && EXTRALANGS="${EXTRALANGS},objc"
	use objc++ && EXTRALANGS="${EXTRALANGS},obj-c++"

	ECONF_SOURCE="${S}" econf --prefix="${EPREFIX}"/usr/$(get_libdir)/${PN}-${MY_PV} \
		$(use_enable multilib) \
		--program-prefix=${PN}-${MY_PV}- \
		--enable-llvm="${EPREFIX}"/usr --enable-languages=c,c++${EXTRALANGS} \
		$(use prefix && echo "--with-local-prefix=${EPREFIX}/usr") \
		|| die "configure failed"
}

src_compile() {
	gcc_do_filter_flags
	cd "${S}"/obj
	BUILDOPTIONS="LLVM_VERSION_INFO=${MY_PV}"
	use bootstrap && BUILDOPTIONS="${BUILDOPTIONS} bootstrap"
	emake ${BUILDOPTIONS} || die "emake failed"
}

src_test() {
	cd "${S}"/obj
	emake -j1 -k check || ewarn "check failed and that sucks :("
}

src_install() {
	cd "${S}"/obj

	# Do allow symlinks in private gcc include dir as this can break the build
	find gcc/include*/ -type l -print0 | xargs -0 rm -f
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in $(find gcc/include*/ -name '*.h') ; do
		grep -q 'It has been auto-edited by fixincludes from' "${x}" \
			&& rm -f "${x}"
	done

	# Parallel install broken, package dropped in next version => -j1
	emake -j1 DESTDIR="${D}" install || die "installation failed"
	rm -rf "${ED}"/usr/share/man/man7
	if ! use nls; then
		einfo "nls USE flag disabled, not installing locale files"
		rm -rf "${ED}"/usr/share/locale
	fi

	# Add some symlinks
	dodir /usr/bin
	cd "${ED}/usr/bin"
	for X in c++ g++ cpp gcc gcov gccbug ; do
		ln -s "${EPREFIX}"/usr/$(get_libdir)/${PN}-${MY_PV}/bin/${PN}-${MY_PV}-${X}  llvm-${X}
	done
	use fortran && \
		ln -s "${EPREFIX}"/usr/$(get_libdir)/${PN}-${MY_PV}/bin/${PN}-${MY_PV}-gfortran llvm-gfortran

	# Fix install_names on Darwin.  The build system is too complicated
	# to just fix this, so we correct it post-install
	if [[ ${CHOST} == *-darwin* ]] ; then
		local f=$(echo "${ED}"usr/$(get_libdir)/${PN}-${MY_PV}/lib/gcc/${CHOST}/${LLVM_GCC_VERSION}*/libstdc++.dylib)
		install_name_tool -id "/${f#${D}}" "${f}"
	fi
}

gcc_do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	# ... sure, why not?
	strip-unsupported-flags

	# dont want to funk ourselves
	filter-flags '-mabi*' -m31 -m32 -m64

	filter-flags '-mcpu=*'
}
