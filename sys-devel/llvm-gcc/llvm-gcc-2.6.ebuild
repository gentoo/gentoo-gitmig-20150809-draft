# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/llvm-gcc/llvm-gcc-2.6.ebuild,v 1.3 2010/01/05 10:19:26 voyageur Exp $

EAPI=2
inherit multilib

LLVM_GCC_VERSION=4.2
MY_PV=${LLVM_GCC_VERSION}-${PV/_pre*}

DESCRIPTION="LLVM C front-end"
HOMEPAGE="http://llvm.org"
SRC_URI="http://llvm.org/releases/${PV}/${PN}-${MY_PV}.source.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bootstrap fortran multilib nls objc objc++ test"

RDEPEND=">=sys-devel/llvm-$PV"
DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/binutils-2.18
	>=sys-devel/bison-1.875
	test? ( dev-util/dejagnu
		sys-devel/autogen )"

S=${WORKDIR}/llvm-gcc${MY_PV}.source/obj

src_prepare() {
	#we keep the directory structure suggested by README.LLVM,
	mkdir -p "${S}"
}

src_configure() {
	# Target options are handled by econf

	EXTRALANGS=""
	use fortran && EXTRALANGS="${EXTRALANGS},fortran"
	use objc && EXTRALANGS="${EXTRALANGS},objc"
	use objc++ && EXTRALANGS="${EXTRALANGS},obj-c++"

	ECONF_SOURCE="${WORKDIR}"/llvm-gcc${MY_PV}.source econf --prefix=/usr/$(get_libdir)/${PN}-${MY_PV} \
		$(use_enable multilib) \
		--program-prefix=${PN}-${MY_PV}- \
		--enable-llvm=/usr --enable-languages=c,c++${EXTRALANGS} \
		|| die "configure failed"
}

src_compile() {
	BUILDOPTIONS="LLVM_VERSION_INFO=${MY_PV}"
	use bootstrap && BUILDOPTIONS="${BUILDOPTIONS} bootstrap"
	emake ${BUILDOPTIONS} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	rm -rf "${D}"/usr/share/man/man7
	if ! use nls; then
		einfo "nls USE flag disabled, not installing locale files"
		rm -rf "${D}"/usr/share/locale
	fi

	# Add some symlinks
	dodir /usr/bin
	cd "${D}/usr/bin"
	for X in c++ g++ cpp gcc gcov gccbug ; do
		ln -s /usr/$(get_libdir)/${PN}-${MY_PV}/bin/${PN}-${MY_PV}-${X}  llvm-${X}
	done
	use fortran && \
		ln -s /usr/$(get_libdir)/${PN}-${MY_PV}/bin/${PN}-${MY_PV}-gfortran llvm-gfortran
}
