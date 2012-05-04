# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/taucs/taucs-2.2.ebuild,v 1.7 2012/05/04 08:22:53 jdhore Exp $

EAPI=4

inherit eutils flag-o-matic fortran-2 toolchain-funcs

DESCRIPTION="C library of sparse linear solvers"
HOMEPAGE="http://www.tau.ac.il/~stoledo/taucs/"
SRC_URI="http://www.tau.ac.il/~stoledo/${PN}/${PV}/${PN}.tgz -> ${P}.tgz"

SLOT="0"
LICENSE="LGPL-2.1"
IUSE="cilk doc static-libs"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	virtual/blas
	virtual/fortran
	virtual/lapack
	|| ( sci-libs/metis sci-libs/parmetis )
	cilk? ( dev-lang/cilk )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"

src_configure() {
	cat > config/linux_shared.mk <<-EOF
		CFLAGS=${CFLAGS} -fPIC
		FC=$(tc-getFC)
		CC=$(tc-getCC)
		FFLAGS=${FFLAGS} -fPIC
		LDFLAGS=${LDFLAGS} -fPIC
		LIBBLAS=$(pkg-config --libs blas)
		LIBLAPACK=$(pkg-config --libs lapack)
		LIBF77=
	EOF
	[[ $(tc-getFC) =~ fortran ]] && echo "LIBF77=-lgfortran" >> config/linux_shared.mk
	echo "LIBMETIS=$(pkg-config --libs metis)" >> config/linux_shared.mk
	# no cat <<EOF because -o has a trailing space
	if use cilk; then
		echo "CILKC=cilkc" >> config/linux_shared.mk
		echo "CILKFLAGS=-O2 -I/usr/include/cilk -fPIC" >> config/linux_shared.mk
		echo "CILKOUTFLG=-o " >> config/linux_shared.mk
	fi
	sed -e 's/ -fPIC//g' \
		config/linux_shared.mk \
		> config/linux_static.mk || die
}

src_compile() {
	# not autotools configure
	if use static-libs; then
		./configure variant=_static || die
		emake
	fi
	./configure variant=_shared || die
	emake

	cd lib/linux_shared
	$(tc-getAR) x libtaucs.a
	$(tc-getLD) $(raw-ldflags) *.o \
		-shared \
		-soname libtaucs.so.1 \
		-o libtaucs.so.1.0.0 \
		$(pkg-config --libs blas lapack metis) \
		|| die "shared lib linking failed"
}

src_test() {
	./testscript variant=_static || die "compile test failed"
	if grep -q FAILED testscript.log; then
		eerror "Test failed. See ${S}/testscript.log"
		die "test failed"
	fi
}

src_install() {
	if use static-libs; then
		dolib.a lib/linux_static/libtaucs.a
	fi
	dolib.so lib/linux_shared/libtaucs.so.1.0.0
	dosym libtaucs.so.1.0.0 /usr/$(get_libdir)/libtaucs.so.1
	dosym libtaucs.so.1 /usr/$(get_libdir)/libtaucs.so

	insinto /usr/include
	doins build/*/*.h src/*.h

	use doc && \
		insinto /usr/share/doc/${PF} && \
		doins doc/*.pdf
}
